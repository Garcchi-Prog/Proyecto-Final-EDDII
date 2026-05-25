extends CanvasLayer

@onready var grid = $TextureRect/Panel/GridContainer

var juicio = null

func _ready():
	juicio = get_tree().current_scene

	for prueba in GameManager.pruebas:

		var boton = Button.new()

		boton.text = prueba[0]

		boton.custom_minimum_size = Vector2(200, 80)

		boton.pressed.connect(
			func():
				seleccionar_prueba(prueba[0])
		)

		grid.add_child(boton)


func seleccionar_prueba(nombre):

	GameManager.prueba_seleccionada = nombre

	queue_free()

	# Mostrar textbox otra vez
	if juicio.balloon:
		juicio.balloon.balloon.show()

	# PRUEBA CORRECTA
	if nombre == juicio.prueba_actual:

		juicio.continuar_dialogo(juicio.label_correcto)

		return

	# PRUEBA INCORRECTA
	juicio.restar_intento()

	if juicio.sin_intentos():

		juicio.continuar_dialogo("game_over")

		return

	# ERROR DE EVIDENCIA
	juicio.continuar_dialogo(juicio.label_error)
