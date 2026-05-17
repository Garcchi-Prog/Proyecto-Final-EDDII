extends Area2D

var prologue_scene = preload("res://scenes/detective/prologue.tscn")
var ya_mostrado = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and not ya_mostrado:
		ya_mostrado = true
		mostrar_prologo()

func mostrar_prologo():
	var prologo = prologue_scene.instantiate()
	# Lo agrega sobre todo lo demás en la escena actual
	get_tree().current_scene.add_child(prologo)
