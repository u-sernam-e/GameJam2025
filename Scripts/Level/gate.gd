extends BlockActivateable

@export var wallTile : TileMapLayer
@export var closed : bool = true
@export var direction: String
@onready var animated_sprite_2d = $AnimatedSprite2D
const TILE_SIZE = Vector2i(16, 16)

func _ready() -> void:
	closed = !closed # toggles this and activates
	activate() 
	
func activate():
	closed = !closed
	var local_pos = wallTile.to_local(global_position)

	var frame_texture = animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, 0)
	var frame_size = frame_texture.get_size()
	if direction == "Vertical":
		frame_size.x *= scale.x
	if direction == "Horizontal":
		frame_size.y *= scale.y
	
	var top_left = local_pos - animated_sprite_2d.offset - frame_size / 2
	var bottom_right = top_left + frame_size
	
	var top_left_tile = wallTile.local_to_map(top_left)
	var bottom_right_tile = wallTile.local_to_map(bottom_right)
	#var gate_size = Vector2i(
		#ceil(frame_size.x / TILE_SIZE.x),
		#ceil(frame_size.y / TILE_SIZE.y)
	#)

	for x in range(top_left_tile.x, bottom_right_tile.x + 1):
		for y in range(top_left_tile.y, bottom_right_tile.y + 1):
			var coords = Vector2i(x, y)
			if closed:
				wallTile.set_cell(coords, 0, Vector2i(0, 3)) # your tile ID
			else:
				wallTile.erase_cell(coords)
				
	if not closed:
		animated_sprite_2d.play("open")
	if closed: 
		animated_sprite_2d.play("close")
		
	Globals.updateTileMap.emit()

	
func _on_area_2d_area_entered(area):
	pass
	if area.is_in_group("character"):
		Globals.stop_movement = true


func _on_area_2d_area_exited(area):
	pass
	if area.is_in_group("character"):
		Globals.stop_movement = false
