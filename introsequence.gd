
extends Control

@export var next_scene: String = "res://Scenes/main.tscn"

@export var character_delay: float = 0.02
@export var text_wait_time: float = 2.0

@onready var text_label: Label = $TextLabel


var dialogue = [
	"You have one week to pay me back, kid.",
	"Try using those tack tick apps\n or whatever they're called.",
	"Be quick with your trades.",
	"And don't make me pay you a visit."
]


func _ready():
	play_sequence()

func _process(delta):
	if Input.is_key_pressed(KEY_F):
		get_tree().change_scene_to_file(next_scene)


func play_sequence():
	for line in dialogue:

		# Set the new text
		text_label.text = line
		text_label.visible_characters = 0

		# Progressively reveal characters
		for i in range(line.length()):
			text_label.visible_characters = i + 1
			await get_tree().create_timer(character_delay).timeout

		# Wait before displaying the next passage
		await get_tree().create_timer(text_wait_time).timeout

	# Switch scene once all passages are finished
	get_tree().change_scene_to_file(next_scene)
