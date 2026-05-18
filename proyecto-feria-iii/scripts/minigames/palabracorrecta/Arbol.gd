extends Button

var palabra = ""

signal palabra_presionada(palabra)


func configurar(texto):

	palabra = texto
	text = texto


func _pressed():

	emit_signal("palabra_presionada", palabra)	
