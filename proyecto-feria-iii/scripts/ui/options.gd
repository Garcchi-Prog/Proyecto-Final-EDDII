extends Control

var modos := ["Normal", "Protanopia", "Deuteranopia", "Tritanopia"]
var modo_actual    := 0
var alto_contraste := false
var pantalla_completa := false

@onready var lbl_daltonico   = $Icn1/VBoxContainer/ModoDaltonico/Label

@onready var btn_contrast_on  = $Icn1/VBoxContainer/AltoContraste/BtnOn
@onready var btn_contrast_off = $Icn1/VBoxContainer/AltoContraste/BtnOff

@onready var barra_general  = $Icn1/VBoxContainer/VolumenGeneral/barra_volumen
@onready var slider_general = $Icn1/VBoxContainer/VolumenGeneral/HSlider
@onready var lbl_general    = $Icn1/VBoxContainer/VolumenGeneral/lbl_porcentaje

@onready var barra_music  = $Icn1/VBoxContainer/VolumenMusica/barra_volumen
@onready var slider_music = $Icn1/VBoxContainer/VolumenMusica/HSlider
@onready var lbl_music    = $Icn1/VBoxContainer/VolumenMusica/lbl_porcentaje

@onready var btn_screen_on  = $Icn1/VBoxContainer/PantallaCompleta/BtnOn
@onready var btn_screen_off = $Icn1/VBoxContainer/PantallaCompleta/BtnOff
@onready var hover_sfx = $TextureButton/AudioStreamPlayer  
@onready var button = $TextureButton                        
func _ready() -> void:

	slider_general.value = AudioManager._master_volume * 100.0
	slider_music.value   = AudioManager._music_volume  * 100.0

	barra_general.value = slider_general.value
	barra_music.value   = slider_music.value

	slider_general.value_changed.connect(_on_slider_general_changed)
	slider_music.value_changed.connect(_on_slider_music_changed)

	actualizar_labels()
	actualizar_daltonico()
	actualizar_contraste_ui()
	actualizar_pantalla_ui()

func _on_btn_left_pressed() -> void:
	modo_actual = (modo_actual - 1 + modos.size()) % modos.size()
	actualizar_daltonico()

func _on_btn_rigth_pressed() -> void:
	modo_actual = (modo_actual + 1) % modos.size()
	actualizar_daltonico()

func actualizar_daltonico() -> void:
	lbl_daltonico.text = modos[modo_actual]
	if VisualManager:
		VisualManager.set_daltonismo(modo_actual)

func _on_btn_on_pressed() -> void:
	alto_contraste = true
	aplicar_contraste()

func _on_btn_off_pressed() -> void:
	alto_contraste = false
	aplicar_contraste()

func aplicar_contraste() -> void:
	if VisualManager:
		VisualManager.set_contrast(1.6 if alto_contraste else 1.0)
	actualizar_contraste_ui()

func actualizar_contraste_ui() -> void:
	btn_contrast_on.modulate  = Color(1,1,1) if alto_contraste     else Color(0.5,0.5,0.5)
	btn_contrast_off.modulate = Color(1,1,1) if not alto_contraste else Color(0.5,0.5,0.5)

func _on_slider_general_changed(value: float) -> void:
	barra_general.value = value
	lbl_general.text = str(int(value)) + "%"
	AudioManager.set_master_volume(value)

func _on_slider_music_changed(value: float) -> void:
	barra_music.value = value
	lbl_music.text = str(int(value)) + "%"
	AudioManager.set_music_volume(value)

func actualizar_labels() -> void:
	lbl_general.text = str(int(slider_general.value)) + "%"
	lbl_music.text   = str(int(slider_music.value))   + "%"

func _on_btn_onpantalla_pressed() -> void:
	pantalla_completa = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	actualizar_pantalla_ui()

func _on_btn_offpantalla_pressed() -> void:
	pantalla_completa = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	actualizar_pantalla_ui()

func actualizar_pantalla_ui() -> void:
	btn_screen_on.modulate  = Color(1,1,1) if pantalla_completa     else Color(0.5,0.5,0.5)
	btn_screen_off.modulate = Color(1,1,1) if not pantalla_completa else Color(0.5,0.5,0.5)

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
