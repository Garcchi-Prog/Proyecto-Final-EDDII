extends Control

var vidas = []

func _ready():

	vidas = $HBoxContainer.get_children()

func actualizar_vidas(intentos):

	for i in range(vidas.size()):
		vidas[i].visible = i < intentos
