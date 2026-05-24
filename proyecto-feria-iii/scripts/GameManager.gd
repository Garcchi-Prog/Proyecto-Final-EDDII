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

func _ready() -> void:
	tube_client.peer_connected.connect(playerConnected.emit)

func _createSession() -> void:
	tube_client.create_session()
	sessionId = tube_client.session_id

func _terminateSession() -> void:
	tube_client._terminate_session()

func _joinSession(roomID: String) -> void:
	tube_client.join_session(roomID)
