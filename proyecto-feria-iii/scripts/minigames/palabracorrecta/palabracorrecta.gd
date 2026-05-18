extends Control

@onready var contenedor = $ContenedorArbol

var escena_nodo = preload("res://scenes/minigames/PalabraCorrecta/NodoArbol.tscn")


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

	# Crear lista base
	var palabras = frase_objetivo.duplicate()

	# Agregar distractores
	distractores.shuffle()

	var cantidad_distractores = randi_range(3, 5)

	for i in range(cantidad_distractores):

		palabras.append(distractores[i])

	# Mezclar distractores
	palabras.shuffle()

	# Crear nodos
	var nodos = []

	for palabra in palabras:

		nodos.append(NodoABB.new(palabra))

	# Construir árbol recursivamente
	raiz = construir_subarbol(nodos)


# =========================================================
# CONSTRUIR SUBARBOL
# =========================================================

func construir_subarbol(lista):

	if lista.is_empty():

		return null

	var nodo = lista.pop_front()

	# Probabilidad de hijos
	if lista.size() > 0 and randf() < 0.8:

		nodo.izquierda = construir_subarbol(lista)

	if lista.size() > 0 and randf() < 0.8:

		nodo.derecha = construir_subarbol(lista)

	return nodo


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

	# Filtrar SOLO palabras de la frase
	var filtradas = []

	for palabra in secuencia_correcta:

		if palabra in frase_objetivo:

			filtradas.append(palabra)

	secuencia_correcta = filtradas


# =========================================================
# PREORDEN
# =========================================================

func preorden(nodo):

	if nodo == null:

		return

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

	dibujar_nodo(raiz, Vector2(700, 120), 350)


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

		dibujar_nodo(
			nodo.izquierda,
			Vector2(
				posicion.x - espacio,
				posicion.y + 140
			),
			espacio * 0.5
		)

	# HIJO DERECHO
	if nodo.derecha != null:

		dibujar_nodo(
			nodo.derecha,
			Vector2(
				posicion.x + espacio,
				posicion.y + 140
			),
			espacio * 0.5
		)
		
