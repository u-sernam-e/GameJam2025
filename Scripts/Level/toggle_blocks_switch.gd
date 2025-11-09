extends CharacterActivateable

@export var toggleBlocks : TileMapLayer

@onready var sprite = $Sprite2D

func activate():
	toggleBlocks.activate()
	if sprite.frame == 0:
		sprite.frame = 1
	else:
		sprite.frame = 0
