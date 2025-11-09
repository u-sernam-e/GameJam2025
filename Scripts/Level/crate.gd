extends Node2D

var inWater : bool = false
var isMoving : bool = false

@export var wallTile : TileMapLayer
@export var waterTile : TileMapLayer

@onready var activate_left = $ActivateAreas/ActivateLeft
@onready var activate_right = $ActivateAreas/ActivateRight
@onready var activate_top = $ActivateAreas/ActivateTop
@onready var activate_bottom = $ActivateAreas/ActivateBottom
@onready var area_pivot = $AreaPivot
@onready var indent_area = $AreaPivot/IndentArea
@onready var wall_area = $AreaPivot/WallArea
@onready var edge_water_area = $AreaPivot/EdgeWaterArea
@onready var center_water_area = $CenterWaterArea

@onready var wall_area_coll_shape = $AreaPivot/WallArea/CollisionShape2D

func _ready() -> void:
	Globals.levelStart.connect(_level_start)
	activate_left.activated.connect(_activated_left)
	activate_right.activated.connect(_activated_right)
	activate_top.activated.connect(_activated_top)
	activate_bottom.activated.connect(_activated_bottom)
	wall_area.body_exited.connect(_wall_exited)

func removeTile():
	var coords : Vector2i = wallTile.local_to_map(wallTile.to_local(global_position))
	wallTile.erase_cell(coords)
	Globals.updateTileMap.emit()

func setTile():
	var coords : Vector2i = wallTile.local_to_map(wallTile.to_local(global_position))
	wallTile.set_cell(coords, 0, Vector2i(1, 1))
	Globals.updateTileMap.emit()

func _level_start():
	setTile()

func moveGround():
	removeTile()
	var nextPostition = position + Vector2(0, -16).rotated(area_pivot.rotation)
	var tween = create_tween()
	tween.finished.connect(_tween_finished)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", nextPostition, 0.5)
	isMoving = true

func moveWater():
	removeTile()
	var nextPostition = position + Vector2(0, -16).rotated(area_pivot.rotation)
	var tween = create_tween()
	tween.finished.connect(_tween_finished)
	tween.tween_property(self, "position", nextPostition, 0.5)
	isMoving = true

func checkMove() -> bool:
	await get_tree().create_timer(0.05).timeout
	if wall_area.has_overlapping_bodies() or wall_area.has_overlapping_areas():
		var coords = wallTile.local_to_map(wallTile.to_local(wall_area_coll_shape.global_position))
		var tileData = wallTile.get_cell_tile_data(coords)
		if tileData and !tileData.get_custom_data("CratePassThrough"):
			return false
	if indent_area.has_overlapping_bodies():
		moveGround()
		return true
	if edge_water_area.has_overlapping_bodies():
		moveWater()
		return true
	return false

func checkInWater():
	if center_water_area.has_overlapping_bodies():
		var coords = waterTile.local_to_map(waterTile.to_local(global_position))
		var tileData = waterTile.get_cell_tile_data(coords)
		area_pivot.rotation = waterTile.stringToRadians(tileData.get_custom_data("direction"))
		set_deferred("wall_area.monitoring", false)
		await get_tree().create_timer(0.05).timeout
		set_deferred("wall_area.monitoring", true)
		checkMove()

# this is just for opening gates
func _wall_exited(_body : Node2D):
	var coords = wallTile.local_to_map(wallTile.to_local(wall_area_coll_shape.global_position))
	var tileData = wallTile.get_cell_tile_data(coords)
	# in animation or next shape is a wall
	if isMoving or (tileData and !tileData.get_custom_data("CratePassThrough")):
		return
	checkInWater()

func _tween_finished():
	isMoving = false
	setTile()
	checkInWater()

func makePlayerMount():
	get_tree().get_first_node_in_group("character").mountCrate(self)

func _activated_left():
	area_pivot.rotation_degrees = 90
	if !(await checkMove()):
		makePlayerMount()
func _activated_right():
	area_pivot.rotation_degrees = 270
	if !(await checkMove()):
		makePlayerMount()
func _activated_top():
	area_pivot.rotation_degrees = 180
	if !(await checkMove()):
		makePlayerMount()
func _activated_bottom():
	area_pivot.rotation_degrees = 0
	if !(await checkMove()):
		makePlayerMount()
