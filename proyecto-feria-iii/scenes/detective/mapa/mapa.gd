extends Node2D
var state: bool = true

func _process(delta):
	state = Global.save
