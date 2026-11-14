extends Camera3D 

@export var target_preset: Node3D
@export var lerp_speed: float = 3

var moving = false

func _process(delta):
	if moving:
		var target_pos = target_preset.global_position
		var target_rotation = target_preset.global_rotation

		global_position = global_position.lerp(target_pos, lerp_speed * delta * lerp_speed)
		global_rotation = global_rotation.slerp(target_rotation, lerp_speed * delta * lerp_speed)

		if global_position.distance_to(target_pos) < 0.01:
			global_position = target_pos
			global_rotation = target_rotation
			moving = false


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			LerpCamToPos()
			print("dags")

func LerpCamToPos():
	moving = true
