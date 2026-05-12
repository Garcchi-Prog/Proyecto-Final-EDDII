extends Control

@onready var rect = $ColorRect

func set_contrast(value):
	if rect.material:
		rect.material.set_shader_parameter("contrast", value)

func set_daltonismo(mode):
	if rect.material:
		rect.material.set_shader_parameter("mode", mode)
