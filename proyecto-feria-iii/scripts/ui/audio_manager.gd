# audio_manager.gd
# Autoload: Proyecto > Ajustes del Proyecto > Globales > Añadir
# Nombre del nodo: AudioManager   Ruta: res://audio_manager.gd
extends Node

# ─── Nodos internos ───────────────────────────────────────────────
var _music_player : AudioStreamPlayer
var _sfx_player   : AudioStreamPlayer

# ─── Estado persistente ───────────────────────────────────────────
var _music_volume  : float = 0.1   # 0.0 – 1.0
var _master_volume : float = 0.7
var _sfx_volume    : float = 1.0
var _current_stream : AudioStream = null

func _ready() -> void:
	# Crear los players internamente: no dependen de ninguna escena
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = "Music"       # bus de audio "Music"
	_music_player.autoplay = false
	add_child(_music_player)

	_sfx_player = AudioStreamPlayer.new()
	_sfx_player.bus = "SFX"           # bus de audio "SFX"
	add_child(_sfx_player)

	# Aplicar volúmenes guardados al iniciar
	_apply_master(_master_volume)
	_apply_music(_music_volume)
	_apply_sfx(_sfx_volume)


# ═══════════════════════════════════════════════
# MÚSICA
# ═══════════════════════════════════════════════

## Reproduce una pista. Si ya está sonando la misma, no la reinicia.
func play_music(stream: AudioStream, loop: bool = true) -> void:
	if stream == _current_stream and _music_player.playing:
		return
	_current_stream = stream
	_music_player.stream = stream
	# Activar loop en el recurso si es AudioStreamMP3 o AudioStreamOggVorbis
	if _music_player.stream is AudioStreamMP3:
		(_music_player.stream as AudioStreamMP3).loop = loop
	elif _music_player.stream is AudioStreamOggVorbis:
		(_music_player.stream as AudioStreamOggVorbis).loop = loop
	_music_player.play()

func stop_music() -> void:
	_music_player.stop()
	_current_stream = null


# ═══════════════════════════════════════════════
# SFX
# ═══════════════════════════════════════════════

func play_sfx(stream: AudioStream) -> void:
	_sfx_player.stream = stream
	_sfx_player.play()


# ═══════════════════════════════════════════════
# VOLUMEN  (recibe 0.0 – 100.0 desde los sliders)
# ═══════════════════════════════════════════════

func set_master_volume(percent: float) -> void:
	_master_volume = percent / 100.0
	_apply_master(_master_volume)

func set_music_volume(percent: float) -> void:
	_music_volume = percent / 100.0
	_apply_music(_music_volume)

func set_sfx_volume(percent: float) -> void:
	_sfx_volume = percent / 100.0
	_apply_sfx(_sfx_volume)

# ── Helpers internos ──────────────────────────
func _apply_master(linear: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(linear)
	)

func _apply_music(linear: float) -> void:
	var idx := AudioServer.get_bus_index("Music")
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(linear))

func _apply_sfx(linear: float) -> void:
	var idx := AudioServer.get_bus_index("SFX")
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, linear_to_db(linear))
