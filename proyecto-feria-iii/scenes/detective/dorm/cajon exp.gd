extends Node

@onready var texture_rect: TextureRect = $TextureRect
@onready var area_2d: Area2D = $TextureRect/Area2D
var inArea: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clic izq") and inArea:
		texture_rect.texture = preload("res://assets/detective/fondo/cerrado.png")
		print("Evidencia encontrada!")
		inArea = false
		area_2d.free()
		
	elif event.is_action_pressed("ui_cancel"):
		salir()

func _on_area_2d_mouse_entered() -> void:
	inArea = true

func _on_area_2d_mouse_exited() -> void:
	inArea = false

func salir() -> void:
	self.visible = false

func _on_button_pressed() -> void:
	salir()
