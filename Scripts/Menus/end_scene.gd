extends Control

func _ready() -> void:
	$Label.text = str(Globals.coin_count)
