extends CharacterActivateable

var coinScene = load("res://Scenes/Level/coin.tscn")
@onready var sprite_2d = $Sprite2D

func activate():
	sprite_2d.play("open")
	for i in randi_range(1, 3):
		var coin = coinScene.instantiate()
		coin.position = Vector2(randi_range(-20, 20), randi_range(-20, 20))
		add_child(coin)
