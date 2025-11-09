extends TileMapLayer

@export var wallTile : TileMapLayer

func _process(_delta: float) -> void:
	for coords in get_used_cells():
		var wallCoords : Vector2i = wallTile.local_to_map(wallTile.to_local(map_to_local(coords)))
		wallTile.set_cell(wallCoords, 0, Vector2i(2, 2))
