extends BaseInstruction
class_name MoveInstruction

@export var moveCoords : Vector2

func doInstruction():
	character.is_moving_to_destination = true
	character.destination_position = (moveCoords/character.movement_script.TILE_SIZE).floor()
	character.move_to_destination()
