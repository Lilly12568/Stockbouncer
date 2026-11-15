extends "res://Scenes/monitor_template.gd"

func _process(delta: float) -> void:
	if Variables.monitors["3"] == null:
		$"Screen".visible = false
	else:
		$"Screen".visible = true

func refresh_screen() -> void:
	if $"Screen".visible:
		var code = Variables.unlocked[Variables.monitors["3"]]
		$Screen/Code.text = str(code)
		$Screen/CurrentPrice.text = str(Variables.stocks[code])
		var average = 0
		var low = 2001
		var high = -1
		for i in range(0,min(15, len(Variables.history[code]))):
			if Variables.history[code][i][0] < low: low = Variables.history[code][i][0]
			if Variables.history[code][i][0] > high: high = Variables.history[code][i][0]
			average += Variables.history[code][i][0]
		average = average / min(15, len(Variables.history[code]))
		for i in range(1, min(16, len(Variables.history[code]) + 1)):
			var dot = $Screen.get_node("Dot" if i == 1 else "Dot%d" % i)
			dot.position = Vector3(0, dot.position.y, dot.position.z) + Vector3((0.3 - 0.6 * (Variables.history[code][i-1][0] - low) / (high - low)), 0, 0)
		update_lines()

func rotate_left(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_left(event, "3")
	refresh_screen()

func rotate_right(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_right(event, "3")
	refresh_screen()
