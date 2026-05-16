extends TextureRect

var click_count: int = 0
var label: Label

func _ready():
	# Habilitar que este nodo reciba input
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Crear el Label para el mensaje (agrégalo como hijo en el editor o créalo aquí)
	label = Label.new()
	label.visible = false
	label.text = "Parece que aquí no hay nada"
	add_child(label)
	
	# Centrar el label dentro del TextureRect
	label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click_count += 1
			print("Clicks: ", click_count)
			
			if click_count >= 10:
				mostrar_mensaje()

func mostrar_mensaje():
	label.visible = true
	print("Parece que aquí no hay nada")
