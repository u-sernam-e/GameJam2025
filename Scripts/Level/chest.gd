extends CharacterActivateable

var coinScene = load("res://Scenes/Level/coin.tscn")

func activate():
	for i in randi_range(1, 3):
		var coin = coinScene.instantiate()
		coin.position = Vector2(randi_range(-20, 20), randi_range(-20, 20))
		add_child(coin)
