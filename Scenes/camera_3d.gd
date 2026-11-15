extends Camera3D

@export var lerp_speed: float = 3.0
@export var z_offset: float = 0.0

@export_group("Mouse Sway")
@export var sway_enabled: bool = true
## Maximum left/right rotation (degrees) away from the resting rotation.
@export var max_sway_yaw_degrees: float = 3.0
## Maximum up/down rotation (degrees) away from the resting rotation.
@export var max_sway_pitch_degrees: float = 2.0
## How quickly the sway catches up to the mouse. Lower = floatier.
@export var sway_smoothing: float = 4.0

@onready var camera_inSound: AudioStreamPlayer3D = $WooshInSound
@onready var camera_outSound: AudioStreamPlayer3D = $WooshOutSound

var moving = false
var returning = false
var can_return = false

var original_position: Vector3
var original_rotation: Quaternion

var target_position: Vector3
var target_rotation: Quaternion

# The "logical" camera pose, without sway. The lerp works on these so the
# sway offset never feeds back into the movement.
var base_position: Vector3
var base_rotation: Quaternion

# Current smoothed sway, in radians (x = pitch, y = yaw)
var sway: Vector2 = Vector2.ZERO


func _ready():
	original_position = global_position
	original_rotation = global_transform.basis.get_rotation_quaternion()

	base_position = original_position
	base_rotation = original_rotation

	# Register camera so monitors can find it
	add_to_group("player_camera")


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

		base_position = base_position.lerp(destination_pos, weight)
		base_rotation = base_rotation.slerp(destination_rot, weight)

		if base_position.distance_to(destination_pos) < 0.01:
			base_position = destination_pos
			base_rotation = destination_rot
			moving = false

	_update_sway(delta)

	# Apply base pose + sway offset (sway is applied in the camera's local space)
	var sway_rotation := Quaternion.from_euler(Vector3(sway.x, sway.y, 0.0))
	global_position = base_position
	global_transform.basis = Basis(base_rotation * sway_rotation)


func _update_sway(delta: float) -> void:
	var desired := Vector2.ZERO

	if sway_enabled:
		var viewport := get_viewport()
		var size := viewport.get_visible_rect().size

		if size.x > 0.0 and size.y > 0.0:
			# Mouse position normalized to -1..1 around the screen center
			var normalized := (viewport.get_mouse_position() / size) * 2.0 - Vector2.ONE
			normalized = normalized.clamp(Vector2(-1, -1), Vector2(1, 1))

			# Mouse right -> look right (negative yaw); mouse up -> look up (positive pitch)
			desired.y = -normalized.x * deg_to_rad(max_sway_yaw_degrees)
			desired.x = -normalized.y * deg_to_rad(max_sway_pitch_degrees)

	var weight := clampf(sway_smoothing * delta, 0.0, 1.0)
	sway = sway.lerp(desired, weight)

	# Hard thresholds: never exceed the configured limits
	var max_yaw := deg_to_rad(max_sway_yaw_degrees)
	var max_pitch := deg_to_rad(max_sway_pitch_degrees)
	sway.y = clampf(sway.y, -max_yaw, max_yaw)
	sway.x = clampf(sway.x, -max_pitch, max_pitch)


func LerpCamToPos(target: Node3D, extra_offset: float = 0):
	camera_inSound.pitch_scale = RandomNumberGenerator.new().randf_range(0.8, 1.2)
	camera_inSound.play()
	if !extra_offset:
		target_position = target.global_position + target.global_basis.z * z_offset
	else:
		target_position = target.global_position + target.global_basis.z * (z_offset + extra_offset)
	
	target_rotation = target.global_basis.get_rotation_quaternion()

	returning = false
	can_return = true
	moving = true


func ReturnCam():
	if not can_return:
		return

	returning = true
	moving = true
	can_return = false
	camera_outSound.pitch_scale = RandomNumberGenerator.new().randf_range(0.8, 1.2)
	camera_outSound.play()
