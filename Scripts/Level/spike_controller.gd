extends BlockActivateable

@export var spikesTileMap : TileMapLayer

func activate():
	for coords in spikesTileMap.get_used_cells():
		if spikesTileMap.get_cell_atlas_coords(coords) == Vector2i(0, 0):
			spikesTileMap.set_cell(coords, 0, Vector2i(3, 0))
		else:
			spikesTileMap.set_cell(coords, 0, Vector2i(0, 0))
