extends Control

@onready var coins_text = $CoinsContainer/CoinsText
@onready var keys_text = $CoinsContainer/KeysText
@onready var start_button = $StartButton

var coins = 0
var keys = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.setCoins.connect(_setCoins)
	Globals.setFilter.connect(_setFilter)
	
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

func _on_start_button_pressed() -> void:
	Globals.level_state = "Execution"
	get_tree().reload_current_scene()
	start_button.disabled = true
	start_button.hide()

func _setCoins(amount : int):
	Globals.coins = amount
	coinsText.text = str(amount)

func _setFilter(amount):
	mouse_filter = amount
