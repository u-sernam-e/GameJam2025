extends Node2D

signal player_did_an_action

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("LeftClick"):
		global_position = get_global_mouse_position()
		player_did_an_action.emit()
		
