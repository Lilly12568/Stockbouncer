extends "res://Scenes/monitor_template.gd"

func _process(delta: float) -> void:
	if Variables.monitors["2"] == null:
		$"Screen".visible = false
	else:
		$"Screen".visible = true
		update_lines()
		$Screen/Label3D.text = str(Variables.unlocked[Variables.monitors["2"]])

func rotate_left(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_left(event, "2")

func rotate_right(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_right(event, "2")
