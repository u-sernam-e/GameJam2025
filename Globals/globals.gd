extends Node

var coins : int = 0
var firstFrame : bool = true
var level_state: String = "Execution" # Level state may be in Inspection phase or Execution phase
var change_screen: bool = false
var stop_movement = false
var activate_death: bool = false

# to be emitted on first frame of level
# is emitted on first frame of game, should also be emitted
# on scene change and when the character dies and level's restarted
signal levelStart

signal updateTileMap

signal moveCamera(moveAmount : Vector2i)

signal setCoins(amount : int)

func _process(_delta: float) -> void:
	if firstFrame:
		levelStart.emit()
		firstFrame = false
