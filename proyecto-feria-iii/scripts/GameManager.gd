extends Node

@onready var tube_client: TubeClient = $TubeClient

signal playerConnected(id: int)
var sessionId: String

var pruebas: Array[Array] = [
	["Chat Sospechoso", false, false],
	["Foto del Live", false, false],
	["Lista de Asistencia", false, false],
	["prueba 4", false, false]
]

var prueba_seleccionada = ""

var lawyerID: int
var detectID: int

func _ready() -> void:
	tube_client.peer_connected.connect(playerConnected.emit)

func _start() -> void:
	if detectID == 1:
		if tube_client.is_server:
			get_tree().change_scene_to_file("res://scenes/detective/prologue.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/lawyer/Juicio.tscn")
	else:
		if tube_client.is_server:
			get_tree().change_scene_to_file("res://scenes/lawyer/Juicio.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/detective/prologue.tscn")

func _createSession() -> void:
	tube_client.create_session()
	sessionId = tube_client.session_id

func _terminateSession() -> void:
	tube_client._terminate_session()

func _joinSession(roomID: String) -> void:
	tube_client.join_session(roomID)
	
func _leaveSession() -> void:
	tube_client.leave_session()
	
func _kick(playerID: int) -> void:
	tube_client.kick_peer(playerID)
