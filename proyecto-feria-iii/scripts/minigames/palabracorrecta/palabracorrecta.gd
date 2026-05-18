extends Control

@onready var contenedor = $ContenedorArbol

var escena_nodo = preload("res://scenes/minigames/PalabraCorrecta/NodoArbol.tscn"		)


# =========================================================
# CONFIGURACION
# =========================================================

var errores_maximos := 5
var errores_actuales := 0


# =========================================================
# FRASE OBJETIVO
# =========================================================

var frase_objetivo = [
	"Preguntar",
	"la",
	"hora",
	"en",
	"la",
	"que",
	"vio",
	"el",
	"mensaje"
]


# =========================================================
# DISTRACTORES
# =========================================================

var distractores = [
	"objecion",
	"fiscal",
	"acusado",
	"prueba",
	"coartada",
	"evidencia",
	"testigo",
	"declaracion",
	"abogado"
]


# =========================================================
# RECORRIDOS
# =========================================================

var tipos_recorrido = [
	"PREORDEN",
	"INORDEN",
	"POSTORDEN"
]

var recorrido_actual = ""


# =========================================================
# ARBOL
# =========================================================

var raiz : NodoABB = null


# =========================================================
# SECUENCIAS
# =========================================================

var secuencia_correcta = []
var secuencia_jugador = []


# =========================================================
# READY
# =========================================================

func _ready():

	randomize()

	iniciar_minijuego()
	dibujar_arbol()


# =========================================================
# INICIAR MINIJUEGO
# =========================================================

func iniciar_minijuego():

	errores_actuales = 0

	secuencia_jugador.clear()

	seleccionar_recorrido()

	construir_arbol()

	obtener_recorrido_correcto()

	debug_arbol()


# =========================================================
# SELECCIONAR RECORRIDO
# =========================================================

func seleccionar_recorrido():

	recorrido_actual = tipos_recorrido.pick_random()


# =========================================================
# CONSTRUIR ARBOL
# =========================================================

func construir_arbol():

	match recorrido_actual:

		"PREORDEN":

			raiz = construir_preorden(frase_objetivo.duplicate())

		"INORDEN":

			raiz = construir_inorden(frase_objetivo.duplicate())

		"POSTORDEN":

			raiz = construir_postorden(frase_objetivo.duplicate())

	# Insertar distractores aleatorios
	insertar_distractores(raiz)	

func construir_preorden(lista):

	if lista.is_empty():

		return null

	var palabra = lista.pop_front()

	var nodo = NodoABB.new(palabra)

	var mitad = lista.size() / 2

	var izquierda_lista = lista.slice(0, mitad)

	var derecha_lista = lista.slice(mitad)

	nodo.izquierda = construir_preorden(izquierda_lista)

	nodo.derecha = construir_preorden(derecha_lista)

	return nodo
	
func construir_inorden(lista):

	if lista.is_empty():

		return null

	var mitad = lista.size() / 2

	var nodo = NodoABB.new(lista[mitad])

	var izquierda_lista = lista.slice(0, mitad)

	var derecha_lista = lista.slice(mitad + 1)

	nodo.izquierda = construir_inorden(izquierda_lista)

	nodo.derecha = construir_inorden(derecha_lista)

	return nodo
	
func construir_postorden(lista):

	if lista.is_empty():

		return null

	var palabra = lista.pop_back()

	var nodo = NodoABB.new(palabra)

	var mitad = lista.size() / 2

	var izquierda_lista = lista.slice(0, mitad)

	var derecha_lista = lista.slice(mitad)

	nodo.izquierda = construir_postorden(izquierda_lista)

	nodo.derecha = construir_postorden(derecha_lista)

	return nodo
	
func insertar_distractores(nodo):

	if nodo == null:

		return

	# IZQUIERDA
	if nodo.izquierda == null and randf() < 0.35:

		nodo.izquierda = NodoABB.new(
			distractores.pick_random(),
			false
		)

	# DERECHA
	if nodo.derecha == null and randf() < 0.35:

		nodo.derecha = NodoABB.new(
			distractores.pick_random(),
			false
		)

	insertar_distractores(nodo.izquierda)

	insertar_distractores(nodo.derecha)	

# =========================================================
# OBTENER RECORRIDO CORRECTO
# =========================================================

func obtener_recorrido_correcto():

	secuencia_correcta.clear()

	match recorrido_actual:

		"PREORDEN":

			preorden(raiz)

		"INORDEN":

			inorden(raiz)

		"POSTORDEN":

			postorden(raiz)


		

# =========================================================
# PREORDEN
# =========================================================

func preorden(nodo):

	if nodo == null:

		return

	if nodo.es_frase:

		secuencia_correcta.append(nodo.palabra)

	preorden(nodo.izquierda)

	preorden(nodo.derecha)		


# =========================================================
# INORDEN
# =========================================================

func inorden(nodo):

	if nodo == null:

		return

	inorden(nodo.izquierda)

	if nodo.es_frase:

		secuencia_correcta.append(nodo.palabra)

	inorden(nodo.derecha)


# =========================================================
# POSTORDEN
# =========================================================

func postorden(nodo):

	if nodo == null:

		return

	postorden(nodo.izquierda)

	postorden(nodo.derecha)

	if nodo.es_frase:

		secuencia_correcta.append(nodo.palabra)		

# =========================================================
# SELECCIONAR PALABRA
# =========================================================

func palabra_seleccionada(palabra):

	var indice = secuencia_jugador.size()

	if palabra == secuencia_correcta[indice]:

		secuencia_jugador.append(palabra)

		print("CORRECTO: ", palabra)

		if secuencia_jugador.size() == secuencia_correcta.size():

			ganar()

	else:

		errores_actuales += 1

		print("ERROR")

		print("Errores: ", errores_actuales)

		if errores_actuales >= errores_maximos:

			perder()


# =========================================================
# GANAR
# =========================================================

func ganar():

	print("MINIJUEGO SUPERADO")


# =========================================================
# PERDER
# =========================================================

func perder():

	print("GAME OVER")

	# get_tree().change_scene_to_file("res://GameOver.tscn")


# =========================================================
# DEBUG
# =========================================================

func debug_arbol():

	print("================================")

	print("RECORRIDO: ", recorrido_actual)

	print("SECUENCIA CORRECTA:")

	print(secuencia_correcta)

	print("================================")


func limpiar_arbol():

	for hijo in contenedor.get_children():

		hijo.queue_free()	



func dibujar_arbol():

	limpiar_arbol()

	var ancho_pantalla = 1920

	dibujar_nodo(raiz, Vector2(ancho_pantalla / 2, 120), 260)


func dibujar_nodo(nodo, posicion, espacio):

	if nodo == null:

		return

	var visual = escena_nodo.instantiate()

	contenedor.add_child(visual)

	visual.position = posicion

	visual.configurar(nodo.palabra)

	visual.palabra_presionada.connect(palabra_seleccionada)

	# HIJO IZQUIERDO
	if nodo.izquierda != null:

		var izquierda_pos = Vector2(
			posicion.x - espacio,
			posicion.y + 120
		)

		dibujar_nodo(
			nodo.izquierda,
			izquierda_pos,
			espacio * 0.55
		)

	# HIJO DERECHO
	if nodo.derecha != null:

		var derecha_pos = Vector2(
			posicion.x + espacio,
			posicion.y + 120
		)

		dibujar_nodo(
			nodo.derecha,
			derecha_pos,
			espacio * 0.55
		)
	
