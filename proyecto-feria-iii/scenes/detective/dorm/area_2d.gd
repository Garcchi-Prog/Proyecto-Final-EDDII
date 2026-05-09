extends Area2D

var abierto = false

@export var textura_abierto: Texture2D
@export var textura_cerrado: Texture2D

func _ready():
	input_pickable = true
	$Sprite2D.texture = textura_cerrado

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		abierto = !abierto
		if abierto:
			$Sprite2D.texture = textura_abierto
		else:
			$Sprite2D.texture = textura_cerrado
