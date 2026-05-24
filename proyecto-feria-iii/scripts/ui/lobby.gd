extends Control

@onready var new_id: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer/New Id"
@onready var room_id: LineEdit = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Room Id"

var ids: Array[int] = [0, 0]

@onready var jugador_1: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/VBoxContainer/Jugador 1"
@onready var jugador_2: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer2/VBoxContainer/Jugador 2"
@onready var desconectar: Button = $MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer3/Desconectar
@onready var start: Button = $MarginContainer/ColorRect/VBoxContainer/CenterContainer/HBoxContainer/Start
@onready var rol_1: Label = $MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/VBoxContainer/Rol1
@onready var rol_2: Label = $MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer2/VBoxContainer/Rol2

var greenStyle: StyleBoxFlat = StyleBoxFlat.new()
var redStyle: StyleBoxFlat = StyleBoxFlat.new()

var isSession: bool = false
var rolesSelected: bool = false

func _ready() -> void:
	GameManager.playerConnected.connect(updateInfo.rpc)
	redStyle.bg_color = Color("af1a1a99")
	greenStyle.bg_color = Color("3a6b0099")

func _on_create_room_pressed() -> void:
	if isSession:
		GameManager._terminateSession()
		isSession = false
		
	GameManager._createSession()
	ids[0] = 1
	isSession = true
	new_id.text = GameManager.sessionId
	
	jugador_1.add_theme_stylebox_override("normal", greenStyle)

func _on_join_room_pressed() -> void:
	if isSession:
		GameManager.tube_client._terminate_session()
		isSession = false
		
	GameManager._joinSession(room_id.text)

@rpc("any_peer", "call_local")
func updateInfo(peerId: int) -> void:
	ids[1] = peerId
	jugador_2.add_theme_stylebox_override("normal", greenStyle)
	
	if !GameManager.tube_client.is_server:
		ids[0] = 1
		jugador_1.add_theme_stylebox_override("nomal", greenStyle)
		isSession = true
	
	desconectar.disabled = false
	
	if GameManager.tube_client.is_server:
		start.disabled = false

func _on_cancel_pressed() -> void:
	if isSession:
		if GameManager.tube_client.is_server:
			GameManager._terminateSession()
		else: 
			GameManager._leaveSession()

	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

@rpc("any_peer", "call_local", "reliable")
func _disconnect():
	jugador_2.add_theme_stylebox_override("normal", redStyle)
	desconectar.disabled = true
	
	if GameManager.tube_client.is_server:
		GameManager._kick(ids[1])
	else:
		isSession = false
		GameManager._leaveSession()
		
func _on_desconectar_pressed() -> void:
	_disconnect().rpc()

@rpc("call_local", "reliable")
func _on_start_pressed() -> void:
	if !rolesSelected:
		GameManager.lawyerID = ids.pick_random()
		GameManager.detectID = ids[0] if ids[1] == GameManager.lawyerID else ids[1]
		
		rol_1.text = "- Detective -" if GameManager.detectID == 1 else "- Abogado -"
		rol_2.text = "- Detective -" if GameManager.lawyerID == 1 else "- Abogado -"
		
		rolesSelected = true
	else:
		GameManager._start.rpc()
	
	
	
	
	
	
	
	
	
