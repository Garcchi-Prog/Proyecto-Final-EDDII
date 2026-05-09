extends Node2D

@onready var cajon_abierto = $CajonAbierto  # Sprite2D de cajon abierto.png
@onready var cajon_cerrado = $CajonCerrado  # Sprite2D de cerrado.png

var esta_abierto = true

func _ready():
	cajon_cerrado.visible = false
	cajon_cerrado.position.y = cajon_abierto.position.y + 150  # Ajusta según tu escena

func toggle_cajon():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	if esta_abierto:
		# Animar cierre: mover hacia abajo y fade out del abierto
		tween.parallel().tween_property(cajon_abierto, "modulate:a", 0.0, 0.3)
		tween.parallel().tween_property(cajon_abierto, "position:y", 
			cajon_abierto.position.y + 150, 0.3)
		
		# Mostrar cerrado
		cajon_cerrado.visible = true
		cajon_cerrado.modulate.a = 0.0
		tween.parallel().tween_property(cajon_cerrado, "modulate:a", 1.0, 0.3)
	else:
		# Animar apertura: invertir la lógica
		tween.parallel().tween_property(cajon_cerrado, "modulate:a", 0.0, 0.3)
		tween.parallel().tween_property(cajon_abierto, "modulate:a", 1.0, 0.3)
		tween.parallel().tween_property(cajon_abierto, "position:y", 
			cajon_abierto.position.y - 150, 0.3)
	
	esta_abierto = !esta_abierto
