extends Node3D

@onready var interaction_area: Area3D = $MonitorCollider


func _ready():
	interaction_area.input_event.connect(_on_input_event)

func _process(delta: float) -> void:
	refresh_news()

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
				player_camera.LerpCamToPos(self, 0.75)

func refresh_news() -> void:
	$"News1".visible = Variables.stories_shown["1"] != null
	$"News2".visible = Variables.stories_shown["2"] != null
	$"News3".visible = Variables.stories_shown["3"] != null
	$"News4".visible = Variables.stories_shown["4"] != null
	$"News5".visible = Variables.stories_shown["5"] != null
	$"News6".visible = Variables.stories_shown["6"] != null
	if Variables.stories_shown["1"] != null:
		$"News1"/Label3D.text = Variables.stories_shown["1"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["1"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["1"][2]][Variables.stories_shown["1"][3]])).replace("%c", str(Variables.stories_shown["1"][3]))
		$"News1"/steal.visible = Variables.stories_shown["1"][5] > 0
	if Variables.stories_shown["2"] != null:
		$"News2"/Label3D.text = Variables.stories_shown["2"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["2"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["2"][2]][Variables.stories_shown["2"][3]])).replace("%c", str(Variables.stories_shown["2"][3]))
		$"News2"/steal.visible = Variables.stories_shown["2"][5] > 0
	if Variables.stories_shown["3"] != null:
		$"News3"/Label3D.text = Variables.stories_shown["3"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["3"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["3"][2]][Variables.stories_shown["3"][3]])).replace("%c", str(Variables.stories_shown["3"][3]))
		$"News3"/steal.visible = Variables.stories_shown["3"][5] > 0
	if Variables.stories_shown["4"] != null:
		$"News4"/Label3D.text = Variables.stories_shown["4"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["4"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["4"][2]][Variables.stories_shown["4"][3]])).replace("%c", str(Variables.stories_shown["4"][3]))
		$"News4"/steal.visible = Variables.stories_shown["4"][5] > 0
	if Variables.stories_shown["5"] != null:
		$"News5"/Label3D.text = Variables.stories_shown["5"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["5"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["5"][2]][Variables.stories_shown["5"][3]])).replace("%c", str(Variables.stories_shown["5"][3]))
		$"News5"/steal.visible = Variables.stories_shown["5"][5] > 0
	if Variables.stories_shown["6"] != null:
		$"News6"/Label3D.text = Variables.stories_shown["6"][0].replace("ㅤ","\n").replace("%p", str(Variables.stories_shown["6"][4]) + "%").replace("%s", str(Variables.companies[Variables.stories_shown["6"][2]][Variables.stories_shown["6"][3]])).replace("%c", str(Variables.stories_shown["6"][3]))
		$"News6"/steal.visible = Variables.stories_shown["6"][5] > 0

func _on_news_1_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News1/steal.visible:
				Variables.steal_news("1")
				refresh_news()

func _on_news_2_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News2/steal.visible:
				Variables.steal_news("2")
				refresh_news()

func _on_news_3_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News3/steal.visible:
				Variables.steal_news("3")
				refresh_news()

func _on_news_4_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News4/steal.visible:
				Variables.steal_news("4")
				refresh_news()

func _on_news_5_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News5/steal.visible:
				Variables.steal_news("5")
				refresh_news()

func _on_news_6_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $News6/steal.visible:
				Variables.steal_news("6")
				refresh_news()
