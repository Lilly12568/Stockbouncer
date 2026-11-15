extends Node3D

@onready var interaction_area: Area3D = $MonitorCollider


func _ready():
	interaction_area.input_event.connect(_on_input_event)

func _process(delta: float) -> void:
	refresh_steal()

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

func refresh_steal() -> void:
	$"monitorMesh"/"NewsSelect1".visible = Variables.stories_saved["1"] != null
	$"monitorMesh"/"NewsSelect2".visible = (Variables.stories_saved["2"] != null)
	$"monitorMesh"/"NewsSelect3".visible = (Variables.stories_saved["3"] != null)
	if Variables.stories_saved["1"] != null:
		$"monitorMesh"/"NewsSelect1"/Label3D.text = Variables.stories_saved["1"][0].replace("ㅤ", " ").replace("%p", str(Variables.stories_saved["1"][4])).replace("%s", str(Variables.companies[Variables.stories_saved["1"][2]][Variables.stories_saved["1"][3]])).replace("%c", str(Variables.stories_saved["1"][3]))
	if Variables.stories_saved["2"] != null:
		$"monitorMesh"/"NewsSelect2"/Label3D.text = Variables.stories_saved["2"][0].replace("ㅤ", " ").replace("%p", str(Variables.stories_saved["2"][4])).replace("%s", str(Variables.companies[Variables.stories_saved["2"][2]][Variables.stories_saved["2"][3]])).replace("%c", str(Variables.stories_saved["2"][3]))
	if Variables.stories_saved["3"] != null:
		$"monitorMesh"/"NewsSelect3"/Label3D.text = Variables.stories_saved["3"][0].replace("ㅤ", " ").replace("%p", str(Variables.stories_saved["3"][4])).replace("%s", str(Variables.companies[Variables.stories_saved["3"][2]][Variables.stories_saved["3"][3]])).replace("%c", str(Variables.stories_saved["3"][3]))


func _on_area_3d_input_event_1(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if true:
				Variables.push_news("1")
				refresh_steal()


func _on_area_3d_input_event_2(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if true:
				Variables.push_news("2")
				refresh_steal()



func _on_area_3d_input_event_3(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if true:
				Variables.push_news("3")
				refresh_steal()
