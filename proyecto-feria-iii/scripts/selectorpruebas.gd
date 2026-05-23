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
	Juicio.espera_prueba = false
	queue_free()
