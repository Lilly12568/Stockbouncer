
extends Control

@onready var menu_container = $MenuContainer
@onready var options_panel = $OptionsPanel


func _ready():
	pass
	#options_panel.hide()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://introsequence.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
