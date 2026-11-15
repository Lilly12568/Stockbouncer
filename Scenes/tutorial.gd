
extends Control

@export var character_delay: float = 0.005
@export var text_wait_time: float = 7

@onready var text_label: Label = $Label
@onready var ding_sound: AudioStreamPlayer3D = $TutorialDings


var dialogue = [
	"You hit rock bottom, but now it's time to get back on your feet! Your loan got you 500$",
	"Start by unlocking a company on the leftmost screen.",
	"The first one is free!",
	"Follow stock prices on the four screens in front.",
	"Buy or sell stocks by clicking on the screens.",
	"See upcoming news broadcasts on the screen on the right!",
	"Steal news broadcasts and make them your own!",
	"Earn enough to pay back your loans.",
	"Good luck!"
]


func _ready():
	if not Variables.playing:
		play_sequence()


func play_sequence():
	for line in dialogue:

		# Set the new text
		text_label.visible = true
		text_label.text = line
		text_label.visible_characters = 0

		# Progressively reveal characters
		for i in range(line.length()):
			text_label.visible_characters = i + 1
			await get_tree().create_timer(character_delay).timeout
			ding_sound.play()

		# Wait before displaying the next passage
		await get_tree().create_timer(text_wait_time).timeout
		
		text_label.visible = false
