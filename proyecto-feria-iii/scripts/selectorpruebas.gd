extends CanvasLayer

@onready var grid = $Panel/GridContainer

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

	if nombre == Juicio.prueba_actual:

		DialogueManager.show_dialogue_balloon(
			load("res://resources/dialogues/Juicio.dialogue"),
			Juicio.label_correcto
		)

	else:

		Juicio.restar_intento()

		if Juicio.sin_intentos():

			DialogueManager.show_dialogue_balloon(
				load("res://resources/dialogues/Juicio.dialogue"),
				"game_over"
			)

		else:

			DialogueManager.show_dialogue_balloon(
				load("res://resources/dialogues/Juicio.dialogue"),
				"evidencia_1"
			)

	queue_free()
