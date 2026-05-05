extends Control

@onready var anim     : AnimationPlayer = $AnimationPlayer
@onready var btn_back : Button = $BtnBack
@onready var tabs     : TabContainer = $Content/Tabs

func _ready() -> void:
	anim.play("enter")
	btn_back.pressed.connect(_on_back)
	btn_back.mouse_entered.connect(func(): MenuAudio.play_hover())

func _on_back() -> void:
	MenuAudio.play_back()
	MenuTransition.go_to("res://scenes/menu/main_menu.tscn")
