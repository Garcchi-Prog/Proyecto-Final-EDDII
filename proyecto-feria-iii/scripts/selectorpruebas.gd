extends CanvasLayer

@onready var grid = $TextureRect/Panel/GridContainer

var juicio = null

# Diccionario: nombre -> ruta imagen
var imagenes_pruebas = {
	"PC institucional": "res://assets/detective/fondo/pc.png",
	"Foto del Live": "res://assets/detective/fondo/cajon abierto.png",
	"Lista de Asistencia": "res://assets/detective/fondo/asistencia borrar.png",
	"Chat Original": "res://assets/detective/evidencia/339f3ed5-7415-4e69-b994-05b4d60cdc52.jpg"
}

func _ready():

	for prueba in GameManager.pruebas:

		var nombre = prueba[0]

		# Crear botón de imagen
		var boton = TextureButton.new()

		# Cargar textura
		var textura = load(imagenes_pruebas[nombre])

		# Asignar imagen
		boton.texture_normal = textura

		# Tamaño fijo
		boton.custom_minimum_size = Vector2(220, 220)

		# Ignorar tamaño original
		boton.ignore_texture_size = true

		# Mantener proporción
		boton.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED

		# Señal
		boton.pressed.connect(
			func():
				seleccionar_prueba(nombre)
		)

		# Agregar al grid
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
