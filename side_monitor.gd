extends Node3D

@onready var interaction_area: Area3D = $MonitorCollider
@onready var purchase_success: AudioStreamPlayer3D = $PurchaseSuccess
@onready var purchase_fail: AudioStreamPlayer3D = $PurchaseFail

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
			if Variables.money < Variables.price:
				purchase_success.play()
				$Price.set("modulate",Color(1,0,0,1))
				while $Price.get("modulate").g < 1:
					$Price.set("modulate",Color(1,$Price.get("modulate").g + 0.01, $Price.get("modulate").b + 0.01,1))
					await get_tree().create_timer(0.01).timeout
			else:
				purchase_fail.play()
				Variables.money -= Variables.price
				$"?".visible = false
				$Code.visible = true
				$Company.visible = true
				$Icon.visible = true
				var stck = Variables.random_path()
				$Icon.text = stck[2][0]
				$Code.text = stck[2].replace(stck[2][0], "")
				$Company.text = stck[1]
				if stck[2] not in Variables.unlocked:
					Variables.unlocked.append(stck[2])
				if len(Variables.unlocked) >= 1 and Variables.monitors["1"] == null:
					Variables.monitors["1"] = 0
				elif len(Variables.unlocked) >= 2 and Variables.monitors["2"] == null:
					Variables.monitors["2"] = 0
				elif len(Variables.unlocked) >= 3 and Variables.monitors["3"] == null:
					Variables.monitors["3"] = 0
				elif len(Variables.unlocked) >= 4 and Variables.monitors["4"] == null:
					Variables.monitors["4"] = 0
