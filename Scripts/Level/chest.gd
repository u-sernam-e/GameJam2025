extends CharacterActivateable

var coinScene = load("res://Scenes/Level/coin.tscn")
@onready var sprite_2d = $Sprite2D

func activate():
	sprite_2d.play("open")
	Globals.coin_count += 5
