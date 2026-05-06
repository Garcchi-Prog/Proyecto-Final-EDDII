extends Control

@onready var hover_sfx = $sfx_hover
@onready var click_sfx = $sfx_click

func _ready():
	_connect_buttons()
	_play_intro_animation()

func _connect_buttons():
	for button in $menu_container.get_children():
		button.mouse_entered.connect(_on_hover.bind(button))
		button.pressed.connect(_on_click.bind(button))

func _on_hover(button):
	hover_sfx.play()
	
	# efecto escala tipo Persona
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.1,1.1), 0.1)

func _on_click(button):
	click_sfx.play()

	match button.name:
		"btn_multiplayer":
			_change_scene("res://scenes/menus/lobby.tscn")
		"btn_options":
			_change_scene("res://scenes/menus/options_menu.tscn")
		"btn_help":
			_change_scene("res://scenes/menus/help_menu.tscn")
		"btn_exit":
			get_tree().quit()

func _change_scene(path):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	get_tree().change_scene_to_file(path)

func _play_intro_animation():
	$AnimationPlayer.play("intro")
