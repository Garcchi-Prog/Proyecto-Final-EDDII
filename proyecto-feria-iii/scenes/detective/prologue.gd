extends Node

func _ready():
	DialogueManager.show_dialogue_balloon(
		load("res://dialogue/prologo_detective.dialogue"),
        "start"
	)
	DialogueManager.dialogue_ended.connect(_on_dialogo_terminado)

func _on_dialogo_terminado(_resource):
	get_tree().change_scene_to_file("res://scenes/detective/mapa/mapa.tscn")
