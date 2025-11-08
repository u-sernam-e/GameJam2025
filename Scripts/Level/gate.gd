extends BlockActivateable

@export var wallTile : TileMapLayer
@export var closed : bool

func _ready() -> void:
	closed = !closed # toggles this and activates
	activate() # to update tilemap
	
func activate():
	closed = !closed
	var coords : Vector2i = wallTile.local_to_map(wallTile.to_local(global_position))
	if closed:
		wallTile.set_cell(coords, 0, Vector2i(1, 1))
	else:
		wallTile.erase_cell(coords)
		
	Globals.updateTileMap.emit()
