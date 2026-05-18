class_name NodoABB

var palabra : String

var izquierda : NodoABB = null
var derecha : NodoABB = null
var es_frase := true


func _init(p : String, frase :=true	):

	palabra = p
	es_frase= frase
