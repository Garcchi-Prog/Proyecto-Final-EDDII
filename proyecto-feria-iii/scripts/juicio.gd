extends Node
var intentos = 5
var max_intentos = 5
var checkpoint_actual = ""

func restar_intento():
	intentos -= 1

func sumar_intento():
	if intentos < max_intentos:
		intentos += 1

func sin_intentos():
	return intentos <= 0

func reiniciar_intentos():
	intentos = max_intentos

func verificar_prueba(prueba_correcta):
	if GameManager.prueba_seleccionada == prueba_correcta:
		return true

	restar_intento()
	return false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
