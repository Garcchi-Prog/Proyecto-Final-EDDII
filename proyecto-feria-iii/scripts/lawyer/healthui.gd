extends Control

@onready var corazones = $HBoxContainer.get_children()

func actualizar_vidas(intentos_actuales):
	for i in range(corazones.size()):

		if i < intentos_actuales:
			corazones[i].visible = true
		else:
			corazones[i].visible = false
