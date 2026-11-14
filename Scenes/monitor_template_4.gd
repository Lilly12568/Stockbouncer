extends "res://Scenes/monitor_template.gd"

@onready var stock = get_parent().monitors


func _process(delta: float) -> void:
	$"Screen".visible = stock["1"] != ""
	$Screen/Dot.position += Vector3(-0.1, 0, 0) * delta
	update_lines()
	$Screen/Label3D.text = str(stock["4"])
	print(stock["4"])
