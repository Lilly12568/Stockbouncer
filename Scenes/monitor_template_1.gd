extends "res://Scenes/monitor_template.gd"

@onready var stock = get_parent().monitors


func _process(delta: float) -> void:
	stock = get_parent().monitors
	if stock["1"] == null:
		$"Screen".visible = false
	else:
		$"Screen".visible = true
		update_lines()
		$Screen/Label3D.text = str(get_parent().unlocked[stock["1"]])

func rotate_left(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and stock["1"] != null:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if stock["1"] == 0:
				get_parent().monitors["1"] = len(get_parent().unlocked) - 1
			else:
				get_parent().monitors["1"] -= 1

func rotate_right(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and stock["1"] != null:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if stock["1"] == len(get_parent().unlocked) - 1:
				get_parent().monitors["1"] = 0
			else:
				get_parent().monitors["1"] += 1