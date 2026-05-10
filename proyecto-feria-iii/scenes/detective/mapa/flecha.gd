extends TextureRect

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_global_rect().has_point(event.global_position):
			if GameManager.escena_anterior != "":
				get_tree().change_scene_to_file(GameManager.escena_anterior)
			else:
				print("No hay escena anterior")
