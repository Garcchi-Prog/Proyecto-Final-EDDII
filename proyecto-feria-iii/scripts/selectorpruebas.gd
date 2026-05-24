extends CanvasLayer

@onready var grid = $TextureRect/Panel/GridContainer

func _ready():

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

	# Volver a mostrar textbox
	if Juicio.balloon:
		Juicio.balloon.balloon.show()

	# PRUEBA CORRECTA
	if nombre == Juicio.prueba_actual:
		Juicio.continuar_dialogo(Juicio.label_error)

		return

	# PRUEBA INCORRECTA
	Juicio.restar_intento()

	if Juicio.sin_intentos():

		Juicio.continuar_dialogo("game_over")

		return

	# Comentario de error
	Juicio.continuar_dialogo("error_evidencia")
