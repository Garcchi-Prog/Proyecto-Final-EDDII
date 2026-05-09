extends Node2D

var inArea: bool = false
@onready var cajon_exp: CanvasLayer = $"Cajon-Exp"
@onready var fondo: TextureRect = $fondo

func _on_cajon_mouse_entered() -> void:
	inArea = true

func _on_cajon_mouse_exited() -> void:
	inArea = false
	
func _input(event: InputEvent) -> void:
	if not inArea:
		return
	
	if event.is_action_pressed("clic izq"):
		fondo.material.set_shader_parameter("strength",10)
		cajon_exp.visible = true
