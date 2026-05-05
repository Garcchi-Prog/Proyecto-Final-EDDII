## MenuAudio — Autoload
## Registrar en: Project > Project Settings > Autoload
## Nombre: MenuAudio   Ruta: res://scripts/ui/menu_audio.gd
extends Node

# Asigna estos AudioStream desde el Inspector del Autoload
# o carga por ruta si los tienes en assets/audio/ui/
@export var hover_sfx  : AudioStream
@export var select_sfx : AudioStream
@export var back_sfx   : AudioStream

var _player : AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	_player.bus = "SFX"          # bus separado del BGM (créalo en Audio > Buses)
	_player.volume_db = -6.0
	add_child(_player)

	# Intentar cargar por ruta si no están asignados en Inspector
	if not hover_sfx:
		hover_sfx  = _try_load("res://assets/audio/ui/hover.ogg")
	if not select_sfx:
		select_sfx = _try_load("res://assets/audio/ui/select.ogg")
	if not back_sfx:
		back_sfx   = _try_load("res://assets/audio/ui/back.ogg")

func _try_load(path: String) -> AudioStream:
	if ResourceLoader.exists(path):
		return load(path)
	return null

func play_hover() -> void:
	_play(hover_sfx, -8.0)

func play_select() -> void:
	_play(select_sfx, -4.0)

func play_back() -> void:
	_play(back_sfx, -4.0)

func _play(stream: AudioStream, vol_db: float) -> void:
	if stream == null:
		return
	_player.stream    = stream
	_player.volume_db = vol_db
	_player.play()
