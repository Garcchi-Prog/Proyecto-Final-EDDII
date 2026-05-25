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
@onready var ui_vidas= $VidaUi

func _ready():
	character_manager = $Character

	ui_vidas.actualizar_vidas(intentos)

	balloon = DialogueManager.show_dialogue_balloon(dialogue_resource,"start")
	DialogueManager.game_states = [self] + DialogueManager.game_states



func _process(_delta):

	if balloon == null:
		return

	# Evita errores cuando no hay línea activa
	if balloon.dialogue_line == null:
		return

	# Evita errores si no existe personaje
	if balloon.dialogue_line.character == null:
		return

	# Obtener personaje actual
	var personaje_actual = balloon.dialogue_line.character

	# Actualizar sprite
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


func verificar_prueba(prueba_correcta):

	if GameManager.prueba_seleccionada == prueba_correcta:
		return true

	restar_intento()

	return false


func mostrar_selector_pruebas():

	prueba_espera = true

	# Ocultar textbox mientras elige prueba
	if balloon:
		balloon.balloon.hide()

	var escena = preload(
		"res://scenes/lawyer/SelectorPruebas.tscn"
	)

	var selector = escena.instantiate()

	get_tree().current_scene.add_child(selector)
