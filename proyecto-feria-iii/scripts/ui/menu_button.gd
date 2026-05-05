## MenuButton — Adjuntar a cada Button del menú
## Efecto: slide a la derecha + sonido al hacer hover
extends Button

@export var slide_amount : float = 12.0   # px que se desplaza al hover
@export var slide_time   : float = 0.10   # segundos de la animación

var _origin_x : float = 0.0
var _tween    : Tween

func _ready() -> void:
	_origin_x = position.x
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)

func _on_hover() -> void:
	_animate(slide_amount)

func _on_exit() -> void:
	_animate(0.0)

func _animate(target_x: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	_tween.tween_property(self, "position:x", _origin_x + target_x, slide_time)
