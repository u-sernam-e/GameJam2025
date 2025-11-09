extends Control

@onready var coins_text = $CoinsContainer/CoinsText
@onready var keys_text = $CoinsContainer/KeysText

var coins = 0
var keys = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.setCoins.connect(_setCoins)
	
func _process(_delta):
	if Globals.coin_count != coins:
		coins = Globals.coin_count
		coins_text.text = str(coins)
	if Globals.key_count != keys:
		keys = Globals.key_count
		keys_text.text = str(keys)

func _setCoins(amount : int):
	Globals.coins = amount
	coins_text.text = str(amount)
