extends Node3D

@onready var interaction_area: Area3D = $MonitorCollider



const LINE_LENGTH := 0.08
const LINE_LIFT := 0.004854433

var dots: Array[Node3D] = []
var lines: Array[MeshInstance3D] = []


func _ready():
	interaction_area.input_event.connect(_on_input_event)

	for i in range(1, 16):
		dots.append($Screen.get_node("Dot" if i == 1 else "Dot%d" % i))
	for i in range(1, 15):
		lines.append($Screen.get_node("ConnectingLine" if i == 1 else "ConnectingLine%d" % i))

	update_lines()

func update_lines() -> void:
	for i in lines.size():
		connect_dots(lines[i], dots[i], dots[i + 1])


func connect_dots(line: MeshInstance3D, a: Node3D, b: Node3D) -> void:
	var dir: Vector3 = b.position - a.position
	var length := dir.length()
	if length < 0.0001:
		line.visible = false
		return
	line.visible = true

	var z := dir.normalized()
	var x := Vector3.UP.cross(z).normalized()
	var y := z.cross(x).normalized()

	line.transform = Transform3D(Basis(x, y, z * (length / LINE_LENGTH)), (a.position + b.position) * 0.5 + Vector3(0, LINE_LIFT, 0))


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
