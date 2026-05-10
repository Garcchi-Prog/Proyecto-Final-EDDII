extends TextureRect

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_global_rect().has_point(event.global_position):
			get_tree().change_scene_to_file("res://scenes/detective/mapa/mapa.tscn")
