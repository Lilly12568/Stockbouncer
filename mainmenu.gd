
extends Control

@onready var menu_container = $MenuContainer
@onready var options_panel = $OptionsPanel


func _ready():
	pass
	#options_panel.hide()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_options_button_pressed():
	menu_container.hide()
	options_panel.show()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	options_panel.hide()
	menu_container.show()
