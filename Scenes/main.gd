extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Variables.start()
	print(Variables.stocks)
	print(Variables.history)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	Variables.tick_stocks()


func _on_days_timer() -> void:
	Variables.tick_days()
