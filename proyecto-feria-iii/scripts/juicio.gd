extends Node
var intentos = 5
var max_intentos = 5
var checkpoint_actual = ""
var prueba_espera = false
var ui_vidas = null
var prueba_actual = ""
var label_correcto = ""
var label_error = ""
var dialogue_resource = load("res://resources/dialogues/Juicio.dialogue")
var balloon = null

func _ready():

	if get_tree().current_scene.has_node("VidaUi"):

		ui_vidas = get_tree().current_scene.get_node("VidaUi")

		ui_vidas.actualizar_vidas(intentos)

		balloon = DialogueManager.show_dialogue_balloon(dialogue_resource,"start")

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

	if balloon:
		balloon.balloon.hide()

	var escena = preload("res://scenes/lawyer/SelectorPruebas.tscn")
	var selector = escena.instantiate()

	get_tree().current_scene.add_child(selector)
