extends Node2D

var dialogue_sc = preload("res://resources/dialogues/Juicio.dialogue")
var minigame_scene = preload("res://scenes/Minijuego.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_sc)
	

func iniciar_minijuego():
	var juego = minigame_scene.instantiate()
	add_child(juego)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
