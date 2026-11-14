
extends Camera3D

@export var clickable_areas: Array[Area3D]
@export var lerp_speed: float = 3.0
@export var z_offset: float = 0.0

var moving = false
var returning = false
var can_return = false

var original_position: Vector3
var original_rotation: Quaternion

var target_position: Vector3
var target_rotation: Quaternion


func _ready():
	original_position = global_position
	original_rotation = global_transform.basis.get_rotation_quaternion()

	# Connect all clickable areas
	for area in clickable_areas:
		if area:
			area.input_event.connect(_on_area_input_event.bind(area))


func _process(delta):
	if moving:
		var destination_pos: Vector3
		var destination_rot: Quaternion

		if returning:
			destination_pos = original_position
			destination_rot = original_rotation
		else:
			destination_pos = target_position
			destination_rot = target_rotation

		var weight = clampf(lerp_speed * delta, 0.0, 1.0)

		global_position = global_position.lerp(destination_pos, weight)

		var current_rotation = global_transform.basis.get_rotation_quaternion()
		var new_rotation = current_rotation.slerp(destination_rot, weight)

		global_transform.basis = Basis(new_rotation)

		if global_position.distance_to(destination_pos) < 0.01:
			global_position = destination_pos
			global_transform.basis = Basis(destination_rot)
			moving = false


func _on_area_input_event(
	camera: Node,
	event: InputEvent,
	event_position: Vector3,
	normal: Vector3,
	shape_idx: int,
	clicked_area: Area3D
) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			LerpCamToPos(clicked_area)


func LerpCamToPos(area: Area3D):
	target_position = area.global_position + area.global_transform.basis.z * z_offset

	target_rotation = area.global_transform.basis.get_rotation_quaternion()

	returning = false
	can_return = true
	moving = true


func ReturnCam():
	if not can_return:
		return

	returning = true
	moving = true
	can_return = false
