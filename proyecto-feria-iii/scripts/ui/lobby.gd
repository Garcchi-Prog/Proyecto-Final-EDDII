extends Control

@onready var new_id: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer/New Id"
@onready var room_id: LineEdit = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer/HBoxContainer/HBoxContainer2/Room Id"
@onready var tube_client: TubeClient = $TubeClient

@onready var jugador_1: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/VBoxContainer/Jugador 1"
@onready var jugador_2: Label = $"MarginContainer/ColorRect/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer2/VBoxContainer/Jugador 2"

var isSession: bool = false

func _ready() -> void:
	jugador_1.text = OS.get_environment("USERNAME")
	

func _on_create_room_pressed() -> void:
	if isSession:
		tube_client._terminate_session()
		isSession = false
		
	tube_client.create_session()
	isSession = true
	new_id.text = tube_client.session_id

func _on_join_room_pressed() -> void:
	if isSession:
		tube_client._terminate_session()
		isSession = false
		
	tube_client.join_session(room_id.text)
