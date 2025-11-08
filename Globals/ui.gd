extends Control

@onready var coinsText = $CoinsContainer/CoinsText

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.setCoins.connect(_setCoins)

func _setCoins(amount : int):
	Globals.coins = amount
	coinsText.text = str(amount)
