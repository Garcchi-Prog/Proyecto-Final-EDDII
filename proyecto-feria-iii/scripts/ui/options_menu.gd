extends Control

@onready var anim         : AnimationPlayer = $AnimationPlayer
@onready var bgm          : AudioStreamPlayer = $BGM
@onready var slider_music : HSlider = $Content/SliderMusic
@onready var slider_sfx   : HSlider = $Content/SliderSFX
@onready var btn_back     : Button  = $BtnBack
@onready var check_color  : CheckButton = $Content/CheckColorblind

const PREF_MUSIC := "audio/music_volume"
const PREF_SFX   := "audio/sfx_volume"
const PREF_COLOR := "accessibility/colorblind"

func _ready() -> void:
	anim.play("enter")
	bgm.play()
	_load_prefs()
	btn_back.pressed.connect(_on_back)
	btn_back.mouse_entered.connect(func(): MenuAudio.play_hover())
	slider_music.value_changed.connect(_on_music_changed)
	slider_sfx.value_changed.connect(_on_sfx_changed)
	check_color.toggled.connect(_on_colorblind_toggled)

func _load_prefs() -> void:
	slider_music.value = ProjectSettings.get_setting(PREF_MUSIC, 1.0)
	slider_sfx.value   = ProjectSettings.get_setting(PREF_SFX, 1.0)
	check_color.button_pressed = ProjectSettings.get_setting(PREF_COLOR, false)

func _on_music_changed(val: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"),
		linear_to_db(val))

func _on_sfx_changed(val: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),
		linear_to_db(val))

func _on_colorblind_toggled(on: bool) -> void:
	# Requerimiento inclusivo: modo alto contraste
	# El backend/UI pueden escuchar esta señal
	pass

func _on_back() -> void:
	MenuAudio.play_back()
	MenuTransition.go_to("res://scenes/menu/main_menu.tscn")
