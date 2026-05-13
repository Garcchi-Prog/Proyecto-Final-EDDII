extends Control
@onready var hover_sfx = $TextureButton/AudioStreamPlayer  
@onready var button = $TextureButton 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_texture_button_pressed() -> void:
	# SONIDO
	if hover_sfx:
		hover_sfx.play()

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(button, "scale", Vector2(1.05, 1.05), 0.08)

	var label = button.get_child(0)
	if label:
		label.modulate = Color(1, 0.2, 0.2)

	await tween.finished
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
