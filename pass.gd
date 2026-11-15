
extends Control

@export var next_scene: String = "res://Scenes/main.tscn"

@export var character_delay: float = 0.02
@export var text_wait_time: float = 2.0

@onready var dialogue_sound: AudioStreamPlayer2D = $DialogueSound
@onready var text_label: Label = $TextLabel

var isLooping = false


var dialogue = [
	"Smart kid.",
	"Don't get lazy, though.",
	"I'll be back again soon."
]


func _ready():
	dialogue_sound.finished.connect(_on_sound_finished)
	play_sequence()


func _process(_delta):
	if Input.is_key_pressed(KEY_F):
		get_tree().change_scene_to_file(next_scene)


func _on_sound_finished():
	if isLooping:
		dialogue_sound.play()


func play_sequence():
	for line in dialogue:

		# Set the new text
		text_label.text = line
		text_label.visible_characters = 0

		# Start dialogue audio and enable looping
		isLooping = true
		dialogue_sound.play()

		# Progressively reveal characters
		for i in range(line.length()):
			text_label.visible_characters = i + 1
			await get_tree().create_timer(character_delay).timeout

		# Disable looping, but let current audio finish
		isLooping = false

		# Wait before displaying the next passage
		await get_tree().create_timer(text_wait_time).timeout

	# Switch scene once all passages are finished
	get_tree().change_scene_to_file(next_scene)
