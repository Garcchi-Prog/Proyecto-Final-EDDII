extends Node

@onready var tube_client: TubeClient = $TubeClient

var detectiveScene := preload("res://scenes/detective/prologue.tscn").instantiate()
var lawyerScene := preload("res://scenes/lawyer/Juicio.tscn").instantiate()

signal playerConnected(id: int)
var sessionId: String

var pruebas: Array[Array] = [
	["Chat Sospechoso", false, false],
	["Foto del Live", false, false],
	["Lista de Asistencia", false, false],
	["Chat Original", false, false]
]

var prueba_seleccionada = ""

var lawyerID: int
var detectID: int

func _ready() -> void:
	tube_client.peer_connected.connect(playerConnected.emit)

@rpc("any_peer", "call_local", "reliable")
func _start():
	if detectID == 1:
		if tube_client.is_server:
			print("hola")
			get_tree().root.add_child(detectiveScene)
		else:
			print("adios")
			get_tree().root.add_child(lawyerScene)
	else:
		if tube_client.is_server:
			print("hola")
			get_tree().root.add_child(lawyerScene)
		else:
			print("adios")
			get_tree().root.add_child(lawyerScene)

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
