extends TextureRect

var ya_clicado: bool = false

func _gui_input(event):
	# Verificamos si es un clic izquierdo y si NO ha sido clicado antes
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not ya_clicado:
			print("¡Encontraste unos chats acerca de valentina!\nLo mandaste a zullivanhdt")
			ya_clicado = true # Cambiamos el estado para bloquear futuros mensajes
