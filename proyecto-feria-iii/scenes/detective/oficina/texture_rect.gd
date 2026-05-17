extends TextureRect

var click_count: int = 0

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click_count += 1
			if click_count >= 5:
				mostrar_dialogo()

func mostrar_dialogo():
	var dialogue_resource = load("res://dialogue/of_dialogo.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource)
