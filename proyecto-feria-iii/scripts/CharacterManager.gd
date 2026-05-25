extends Control

@onready var personaje = $TextureRect

var sprites = {
	"Defensa_normal":
		preload("res://resources/Sprites/abogado/normal.png"),

	"Defensa_pensando":
		preload("res://resources/Sprites/abogado/thinking.png"),

	"Defensa_enojado":
		preload("res://resources/Sprites/abogado/enojado.png"),

	"Fiscal_normal":
		preload("res://resources/Sprites/fiscal/f nor.png"),
	
	"Fiscal_pensando":
		preload("res://resources/Sprites/fiscal/f thinking.png"),

	"Lilliana_hablando":
		preload("res://resources/Sprites/lilliana/lili hablando.png"),

	"Lilliana_feliz":
		preload("res://resources/Sprites/lilliana/lili normal.png"),
	
	"Lilliana_enojada":
		preload("res://resources/Sprites/lilliana/lili enojada.png"),
	
	"Valentina_normal":
		preload("res://resources/Sprites/valentina/va normal.png"),
	
	"Juez":
		preload ("res://resources/Sprites/juez/juez.png")
}


func mostrar_sprite(nombre):

	personaje.texture = sprites[nombre]
	personaje.visible = true


func ocultar_sprite():

	personaje.visible = false

func actualizar_personaje(nombre):

	match nombre:

		"Defensa":
			mostrar_sprite("Defensa_normal")

		"Fiscal":
			mostrar_sprite("Fiscal_normal")

		"Lilliana":
			mostrar_sprite("Lilliana_hablando")

		"Valentina":
			mostrar_sprite("Valentina_normal")

		"Juez":
			mostrar_sprite("Juez")

		_:
			ocultar_sprite()
