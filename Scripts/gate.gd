extends Marker2D

@export var id : int
@export var wallTile : TileMapLayer
@export var closed : bool


func _ready() -> void:
	Globals.activate.connect(_activate)
	
	closed = !closed # toggles this and activates
	_activate(id) # to update tilemap
	
func _activate(inId : int):
	if inId == id:
		closed = !closed
		var coords : Vector2i = wallTile.local_to_map(wallTile.to_local(global_position))
		if closed:
			wallTile.set_cell(coords, 0, Vector2i(1, 1))
		else:
			wallTile.erase_cell(coords)
