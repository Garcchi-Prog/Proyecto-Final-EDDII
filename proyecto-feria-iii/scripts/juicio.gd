extends Node

var intentos = 5
var max_intentos = 5
var checkpoint_actual = ""
var prueba_espera = false
var prueba_actual = ""
var label_correcto = ""
var label_error = ""
var dialogue_resource = load("res://resources/dialogues/Juicio.dialogue")
var balloon = null
var character_manager = null

@onready var ui_vidas = $VidaUi

func _ready():
	character_manager = $Character
	ui_vidas.actualizar_vidas(intentos)
	balloon = DialogueManager.show_dialogue_balloon(dialogue_resource, "start", [self])

func _process(_delta):
	if balloon == null:
		return
	if balloon.dialogue_line == null:
		return
	if balloon.dialogue_line.character == null:
		return
	var personaje_actual = balloon.dialogue_line.character
	if character_manager:
		character_manager.actualizar_personaje(personaje_actual)

func continuar_dialogo(label):
	if balloon:
		balloon.next(label)

func restar_intento():
	intentos -= 1
	if ui_vidas:
		ui_vidas.actualizar_vidas(intentos)

func sumar_intento():
	if intentos < max_intentos:
		intentos += 1
		if ui_vidas:
			ui_vidas.actualizar_vidas(intentos)

func sin_intentos():
	return intentos <= 0

func reiniciar_intentos():
	intentos = max_intentos
	if ui_vidas:
		ui_vidas.actualizar_vidas(intentos)

func set_checkpoint(valor):
	checkpoint_actual = valor

func set_prueba(prueba, correcto, error):
	prueba_actual = prueba
	label_correcto = correcto
	label_error = error

func verificar_prueba(prueba_correcta):
	if GameManager.prueba_seleccionada == prueba_correcta:
		return true
	restar_intento()
	return false

func mostrar_selector_pruebas():
	prueba_espera = true
	if balloon:
		balloon.balloon.hide()
	var escena = preload("res://scenes/lawyer/SelectorPruebas.tscn")
	var selector = escena.instantiate()
	selector.juicio = self
	get_tree().current_scene.add_child(selector)

@rpc("any_peer", "call_local", "reliable")
func terminar_juego():
	if GameManager.tube_client.is_server:
		if GameManager.detectID == 1:
			GameManager._kick(GameManager.lawyerID)
		else:
			GameManager._kick(GameManager.detectID)
		
		GameManager._terminateSession()
	
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	
	for prueba in GameManager.pruebas:
		prueba[1] = false
		prueba[2] = false
