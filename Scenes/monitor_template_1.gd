extends "res://Scenes/monitor_template.gd"

func _process(delta: float) -> void:
	$Screen/Dot.position += Vector3(-0.1, 0, 0) * delta