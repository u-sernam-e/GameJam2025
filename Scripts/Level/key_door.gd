extends BlockActivateable

var create_blocks = false
var activated_door = false
@export var wallTile : TileMapLayer
@onready var animated_sprite_2d = $StaticBody2D/Sprite2D
const TILE_SIZE = Vector2i(16, 16)

func _ready() -> void:
	activate() 
	
func activate():
	var local_pos = wallTile.to_local(global_position)

	var frame_texture = animated_sprite_2d.sprite_frames.get_frame_texture(animated_sprite_2d.animation, 0)
	var frame_size = frame_texture.get_size()
	
	var top_left = local_pos - animated_sprite_2d.offset - frame_size / 2
	var bottom_right = top_left + frame_size
	
	var top_left_tile = wallTile.local_to_map(top_left)
	var bottom_right_tile = wallTile.local_to_map(bottom_right)

	for x in range(top_left_tile.x, bottom_right_tile.x + 1):
		for y in range(top_left_tile.y, bottom_right_tile.y + 1):
			var coords = Vector2i(x, y)
			if !create_blocks:
				wallTile.set_cell(coords, 0, Vector2i(0, 3)) # your tile ID
			else:
				wallTile.erase_cell(coords)
				
	create_blocks = true
	Globals.updateTileMap.emit()
	
	if activated_door:
		call_deferred("queue_free")

	
func _on_area_2d_area_entered(area):
	pass
	if area.is_in_group("character"):
		Globals.stop_movement = true


func _on_area_2d_area_exited(area):
	pass
	if area.is_in_group("character"):
		Globals.stop_movement = false


func _on_static_body_2d_area_entered(area):
	if area.is_in_group("character"):
		if Globals.key_count > 0:
			Globals.key_count -= 1
			if Globals.key_count < 0:
				Globals.key_count = 0
			activated_door = true
			activate()
