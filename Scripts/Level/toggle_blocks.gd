extends TileMapLayer

@export var wallTile : TileMapLayer

func _ready() -> void:
	Globals.levelStart.connect(_first_frame)

func _first_frame():
	activate()
	activate()

func activate():
	for coords in get_used_cells():
		var wallCoords : Vector2i = wallTile.local_to_map(wallTile.to_local(map_to_local(coords)))
		if get_cell_atlas_coords(coords) == Vector2i(1, 0):
			wallTile.set_cell(wallCoords, 0, Vector2i(0, 3))
			set_cell(coords, 0, Vector2i(0, 0))
		else:
			wallTile.erase_cell(wallCoords)
			set_cell(coords, 0, Vector2i(1, 0))
	Globals.updateTileMap.emit()
