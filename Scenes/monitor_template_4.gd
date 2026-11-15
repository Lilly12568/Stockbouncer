extends "res://Scenes/monitor_template.gd"

func _process(delta: float) -> void:
	if Variables.monitors["4"] == null:
		$"Screen".visible = false
	else:
		$"Screen".visible = true

func refresh_screen() -> void:
	if $"Screen".visible:
		$Screen/Code.text = str(Variables.unlocked[Variables.monitors["4"]])
		$Screen/CurrentPrice.text = str(Variables.stocks[Variables.unlocked[Variables.monitors["4"]]])
		var average = 0
		var low = 2001
		var high = -1
		for i in range(0,min(15, len(Variables.history[Variables.unlocked[Variables.monitors["4"]]]))):
			if Variables.history[Variables.unlocked[Variables.monitors["4"]]][i][0] < low: low = Variables.history[Variables.unlocked[Variables.monitors["4"]]][i][0]
			if Variables.history[Variables.unlocked[Variables.monitors["4"]]][i][0] < high: high = Variables.history[Variables.unlocked[Variables.monitors["4"]]][i][0]
			average += Variables.history[Variables.unlocked[Variables.monitors["4"]]][i][0]
		average = average / min(15, len(Variables.history[Variables.unlocked[Variables.monitors["4"]]]))
		for i in range(1, min(16, len(Variables.history[Variables.unlocked[Variables.monitors["4"]]]) + 1)):
			var dot = $Screen.get_node("Dot" if i == 1 else "Dot%d" % i)
			var deviation = (average - Variables.history[Variables.unlocked[Variables.monitors["4"]]][i-1][0]) / average
			dot.position = Vector3(0, dot.position.y, dot.position.z) + Vector3(deviation * 0.3, 0, 0)
		update_lines()

func rotate_left(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_left(event, "4")
	refresh_screen()

func rotate_right(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_right(event, "4")
	refresh_screen()
