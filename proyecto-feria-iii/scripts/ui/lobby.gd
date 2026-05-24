extends Control

@onready var new_id: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer/New Id"
@onready var room_id: LineEdit = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Room Id"
var Player1_ID: int
var player2_ID: int
@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer

@onready var jugador_1: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/VBoxContainer/Jugador 1"
@onready var jugador_2: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer2/VBoxContainer/Jugador 2"

var greenStyle: StyleBoxFlat = StyleBoxFlat.new()
var redStyle: StyleBoxFlat = StyleBoxFlat.new()

var isSession: bool = false

func _ready() -> void:
	GameManager.playerConnected.connect(updateInfo)
	redStyle.bg_color = Color("af1a1a99")
	greenStyle.bg_color = Color("3a6b0099")

func _on_create_room_pressed() -> void:
	if isSession:
		GameManager._terminateSession()
		isSession = false
		
	GameManager._createSession()
	Player1_ID = 1
	isSession = true
	new_id.text = GameManager.sessionId
	
	jugador_1.add_theme_stylebox_override("normal", greenStyle)

func _on_join_room_pressed() -> void:
	if isSession:
		GameManager.tube_client._terminate_session()
		isSession = false
		
	GameManager._joinSession(room_id.text)

func updateInfo(peerId: int) -> void:
	player2_ID = peerId
	jugador_2.add_theme_stylebox_override("normal", greenStyle)
	
	print(GameManager.tube_client.is_server)
	print(isSession)

func _on_cancel_pressed() -> void:
	if GameManager.tube_client.is_server:
		GameManager._terminateSession()
	else: 
		pass
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_desconectar_pressed() -> void:
	pass # Replace with function body.
