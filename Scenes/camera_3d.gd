extends Camera3D # Use Camera3D if you are in 3D

# Reference or path to your preset node
@export var target_preset: Node3D # Use Node3D if you are in 3D

# Smoothing factor (higher = faster, lower = slower/smoother, usually between 0.05 and 0.2)
@export var lerp_speed: float = 0.1

func _process(delta: float) -> void:
	pass


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if target_preset and event is InputEventMouseButton:
		LerpCamToPos()

func LerpCamToPos():
	var moving = false
	
	# Get the target position (global_position is safest)
	var target_pos = target_preset.global_position
	var target_rotation = target_preset.global_rotation
	
	if !moving:
			# Linearly interpolate current position to target position
		global_position = global_position.lerp(target_pos, lerp_speed)
		global_rotation = global_rotation.lerp(target_rotation, lerp_speed)
		LerpCamToPos()
	else:
		pass
