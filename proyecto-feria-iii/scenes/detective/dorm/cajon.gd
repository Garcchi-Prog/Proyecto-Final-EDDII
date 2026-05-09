extends Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("Parece que alguien lo dejo para mi \ntomaste foto de live")
			get_tree().change_scene_to_file("res://scenes/detective/dorm/cajon evidencia.tscn")
			
