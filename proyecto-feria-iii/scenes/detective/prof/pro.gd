extends Node2D

var inArea: bool = false
@onready var cajon_exp: CanvasLayer = $prof
@onready var fondo: TextureRect = $fondo

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clic izq"):
		if not inArea:
			return
	
	if event.is_action_pressed("clic izq"):
		fondo.material.set_shader_parameter("strength",10)
		cajon_exp.visible = true


func _on_papelera_mouse_entered() -> void:
	inArea = true


func _on_papelera_mouse_exited() -> void:
	inArea = false
