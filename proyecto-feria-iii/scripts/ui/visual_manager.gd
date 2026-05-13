# visual_manager.gd
# Autoload existente: res://scenes/menu/visual_manager.tscn
# Este script ya está en tu Autoload como "VisualManager".
# Árbol de la escena: Node (visual_manager.tscn)
#   └── ColorRect       ← cubre toda la pantalla, material = ShaderMaterial con main_menu.gdshader
#
# En el Inspector del ColorRect:
#   - Anchors: Full Rect  (cubre toda la ventana)
#   - Mouse Filter: Ignore  (no bloquea clicks)
#   - CanvasLayer del nodo raíz: capa 128 o superior (siempre encima del juego)

extends Node   # <-- CAMBIAR de Control a Node si el nodo raíz de la escena es un Node simple
			   #     Si la escena tiene CanvasLayer como raíz, extiende CanvasLayer

@onready var rect : ColorRect = $ColorRect

# Estado actual (para persistir entre escenas)
var _current_mode    : int   = 0
var _current_contrast: float = 1.0

func _ready() -> void:
	# Asegurarse de que el material existe antes de escribir parámetros
	if not rect.material:
		push_error("VisualManager: ColorRect no tiene ShaderMaterial asignado.")
		return
	_apply_shader()


# ═══════════════════════════════════════════════
# API PÚBLICA  (llamada desde options.gd)
# ═══════════════════════════════════════════════

## mode: 0=Normal  1=Protanopia  2=Deuteranopia  3=Tritanopia
func set_daltonismo(mode: int) -> void:
	_current_mode = mode
	_apply_shader()

## value: 1.0 = normal, 1.6 = alto contraste
func set_contrast(value: float) -> void:
	_current_contrast = value
	_apply_shader()


# ── Helper interno ────────────────────────────
func _apply_shader() -> void:
	if rect and rect.material:
		rect.material.set_shader_parameter("mode",     _current_mode)
		rect.material.set_shader_parameter("contrast", _current_contrast)
