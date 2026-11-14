
extends Control

@export var camera: Camera3D

@onready var indicator = $Panel


func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	indicator.visible = false


func _process(_delta):
	# Show indicator whenever returning is available
	indicator.visible = camera.can_return


func _on_mouse_entered():
	if camera.can_return:
		camera.ReturnCam()


func _on_mouse_exited():
	pass
