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

func _process(delta: float) -> void:
	$"Quota days".text = "IN " + str(Variables.days) + " DAYS"
	$"Price".text = str(Variables.price)
	$"Quota".text = str(Variables.quota)
	$"Balance".text = str(Variables.money)

func _on_buy_push(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$"?".visible = false
			$Code.visible = true
			$Company.visible = true
			$Icon.visible = true
			var stck = Variables.random_path()
			$Icon.text = stck[2][0]
			$Code.text = stck[2].lstrip(1)
			$Company.text = stck[1]