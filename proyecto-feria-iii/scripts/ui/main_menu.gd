extends Control

# ── Nodos ──────────────────────────────────────────────────────────────
@onready var anim        : AnimationPlayer = $AnimationPlayer
@onready var bgm         : AudioStreamPlayer = $BGM
@onready var logo        : TextureRect       = $Logo
@onready var btn_multi   : Button = $Buttons/BtnMultiplayer
@onready var btn_options : Button = $Buttons/BtnOpciones
@onready var btn_help    : Button = $Buttons/BtnAyuda
@onready var btn_quit    : Button = $Buttons/BtnSalir
@onready var status_icon : TextureRect = $StatusBar/Icon
@onready var status_lbl  : Label       = $StatusBar/Label

# ── Rutas de escenas ───────────────────────────────────────────────────
const SCENE_MULTI   := "res://scenes/menu/multiplayer_menu.tscn"
const SCENE_OPTIONS := "res://scenes/menu/options_menu.tscn"
const SCENE_HELP    := "res://scenes/menu/help_menu.tscn"

# ── Ready ──────────────────────────────────────────────────────────────
func _ready() -> void:
	# Entrada animada
	anim.play("menu_enter")
	bgm.play()

	# Señales de botones
	btn_multi.pressed.connect(_on_multiplayer)
	btn_options.pressed.connect(_on_options)
	btn_help.pressed.connect(_on_help)
	btn_quit.pressed.connect(_on_quit)

	# Hover sound en todos los botones
	for btn in [btn_multi, btn_options, btn_help, btn_quit]:
		btn.mouse_entered.connect(func(): MenuAudio.play_hover())

	_update_status()

# ── Estado de conexión ─────────────────────────────────────────────────
func _update_status() -> void:
	# El backend debe tener un autoload "NetworkManager" con .is_connected
	if Engine.has_singleton("NetworkManager"):
		var connected : bool = NetworkManager.is_connected
		status_lbl.text = "CONECTADO" if connected else "DESCONECTADO"
		status_lbl.modulate = Color.WHITE if connected else Color(0.6, 0.6, 0.6)
	else:
		status_lbl.text = "OFFLINE"

# ── Navegación ─────────────────────────────────────────────────────────
func _on_multiplayer() -> void:
	MenuAudio.play_select()
	MenuTransition.go_to(SCENE_MULTI)

func _on_options() -> void:
	MenuAudio.play_select()
	MenuTransition.go_to(SCENE_OPTIONS)

func _on_help() -> void:
	MenuAudio.play_select()
	MenuTransition.go_to(SCENE_HELP)

func _on_quit() -> void:
	MenuAudio.play_select()
	anim.play("menu_exit")
	await anim.animation_finished
	get_tree().quit()
