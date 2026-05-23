extends Node
var intentos = 5
var max_intentos = 5
var checkpoint_actual = ""
var prueba_espera = false
var ui_vidas = null


func _ready():
	ui_vidas = get_tree().current_scene.get_node("VidaUi")
	ui_vidas.actualizar_vidas(intentos)
	DialogueManager.show_dialogue_balloon(
		load("res://resources/dialogues/Juicio.dialogue"),
		"start")




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
	var escena = preload("res://scenes/lawyer/SelectorPruebas.tscn")
	var selector = escena.instantiate()
	get_tree().current_scene.add_child(selector)
