## MenuTransition — Autoload
## Registrar en: Project > Project Settings > Autoload
## Nombre: MenuTransition   Ruta: res://scripts/ui/menu_transition.gd
extends CanvasLayer

var _overlay : ColorRect
var _tween   : Tween
var _busy    : bool = false

const FADE_TIME := 0.35

func _ready() -> void:
	layer = 100  # siempre encima de todo
	_overlay = ColorRect.new()
	_overlay.color = Color.BLACK
	_overlay.modulate.a = 0.0
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(_overlay)

## Cambia a otra escena con fade negro
func go_to(scene_path: String) -> void:
	if _busy:
		return
	_busy = true
	_overlay.mouse_filter = Control.MOUSE_FILTER_STOP  # bloquea input durante transición

	# Fade OUT
	_tween = create_tween().set_ease(Tween.EASE_IN)
	_tween.tween_property(_overlay, "modulate:a", 1.0, FADE_TIME)
	await _tween.finished

	get_tree().change_scene_to_file(scene_path)

	# Fade IN en la nueva escena
	_tween = create_tween().set_ease(Tween.EASE_OUT)
	_tween.tween_property(_overlay, "modulate:a", 0.0, FADE_TIME)
	await _tween.finished

	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_busy = false
