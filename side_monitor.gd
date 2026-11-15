extends Node3D

@onready var interaction_area: Area3D = $MonitorCollider


func _ready():
	interaction_area.input_event.connect(_on_input_event)


func _on_input_event(
	camera: Node,
	event: InputEvent,
	event_position: Vector3,
	normal: Vector3,
	shape_idx: int
):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			var player_camera = get_tree().get_first_node_in_group("player_camera")

			if player_camera:
				player_camera.LerpCamToPos(self)
