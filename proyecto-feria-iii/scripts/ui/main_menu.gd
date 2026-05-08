extends Control

@onready var hover_sfx = $sfx_hover
@onready var click_sfx = $sfx_click
@onready var music = $music
@onready var animation_player = $AnimationPlayer

@onready var btn_multiplayer = $btn_multiplayer
@onready var btn_options = $btn_options
@onready var btn_credits = $btn_credits
@onready var btn_exit = $btn_exit

func _ready():

	if music:
		music.play()

	if animation_player:
		animation_player.play("intro")

	_connect_button(btn_multiplayer)
	_connect_button(btn_options)
	_connect_button(btn_credits)
	_connect_button(btn_exit)

	btn_multiplayer.pressed.connect(_on_multiplayer_pressed)
	btn_options.pressed.connect(_on_options_pressed)
	btn_credits.pressed.connect(_on_credits_pressed)
	btn_exit.pressed.connect(_on_exit_pressed)

func _connect_button(button):

	# CENTRO ESCALADO
	button.pivot_offset = button.size / 2

	# HOVER
	button.mouse_entered.connect(_on_button_hover.bind(button))
	button.mouse_exited.connect(_on_button_exit.bind(button))

func _on_button_hover(button):

	# SONIDO
	if hover_sfx:
		hover_sfx.play()

	# TWEEN
	var tween = create_tween()

	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	# ESCALA
	tween.tween_property(
		button,
		"scale",
		Vector2(1.05, 1.05),
		0.08
	)

	# LABEL
	var label = button.get_child(0)

	if label:
		label.modulate = Color(1, 0.2, 0.2)

func _on_button_exit(button):

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)

	# VOLVER NORMAL
	tween.tween_property(
		button,
		"scale",
		Vector2.ONE,
		0.08
	)

	# LABEL BLANCO
	var label = button.get_child(0)

	if label:
		label.modulate = Color.WHITE

func _on_multiplayer_pressed():
	_play_click()

	get_tree().change_scene_to_file(
		"res://scenes/menu/lobby.tscn"
	)

func _on_options_pressed():

	_play_click()

	get_tree().change_scene_to_file(
		"res://scenes/menu/options.tscn"
	)

func _on_credits_pressed():

	_play_click()

	get_tree().change_scene_to_file(
		"res://scenes/menu/credits.tscn"
	)

func _on_exit_pressed():

	_play_click()

	get_tree().quit()

func _play_click():

	if click_sfx:
		click_sfx.play()
