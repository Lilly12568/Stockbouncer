extends "res://Scenes/monitor_template.gd"

var low_at = 2001
var high_at = -1


func _process(delta: float) -> void:
	if Variables.monitors["2"] == null:
		$"Screen".visible = false
	else:
		$"Screen".visible = true

func refresh_screen() -> void:
	if $"Screen".visible:
		var code = Variables.unlocked[Variables.monitors["2"]]
		$Screen/Code.text = str(code)
		$Screen/CurrentPrice.text = str(Variables.stocks[code])
		var average = 0
		var low = 2001
		var high = -1
		for i in range(0,min(15, len(Variables.history[code]))):
			if Variables.history[code][i][0] < low: low = Variables.history[code][i][0]
			if Variables.history[code][i][0] > high: high = Variables.history[code][i][0]
			average += Variables.history[code][i][0]
		if high > high_at:
			high_at = high
		if low < low_at:
			low_at = low
		average = average / min(15, len(Variables.history[code]))
		for i in range(1, min(16, len(Variables.history[code]) + 1)):
			var dot = $Screen.get_node("Dot" if i == 1 else "Dot%d" % i)
			dot.position = Vector3(0, dot.position.y, dot.position.z) + Vector3((0.3 - 0.6 * (Variables.history[code][i-1][0] - low_at) / (high_at - low_at)), 0, 0)
		$Screen/MinPrice.text = str(low_at)
		$Screen/MaxPrice.text = str(high_at)
		if Variables.inventory[code] > 0:
			$Screen/UD.text = "$" + str(Variables.round_to_decimal(average - (Variables.bought_in[code]/Variables.inventory[code]), 2))
			$Screen/UD.modulate = Color(1, 0, 0) if Variables.round_to_decimal(average - (Variables.bought_in[code]/Variables.inventory[code]), 2) < 0 else Color(0, 1, 0)
		else:
			$Screen/UD.text = ""
		$Screen/SellArea/SellButton/Label3D2.text = "SELL (0.1/" + str(Variables.inventory[code]) + ")"
		update_lines()

func rotate_left(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_left(event, "2")
	refresh_screen()

func rotate_right(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	Variables.rotate_right(event, "2")
	refresh_screen()

func buy_stock() -> void:
	if Variables.monitors["2"] != null:
		Variables.buy_stock(Variables.unlocked[Variables.monitors["2"]])

func sell_stock() -> void:
	if Variables.monitors["2"] != null:
		Variables.sell_stock(Variables.unlocked[Variables.monitors["2"]])
