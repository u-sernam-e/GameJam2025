extends Node2D

@export var wallTile : TileMapLayer

@onready var activate_left = $ActivateLeft
@onready var activate_right = $ActivateRight
@onready var activate_top = $ActivateTop
@onready var activate_bottom = $ActivateBottom
@onready var indent_pivot = $IndentBoxPivot
@onready var indent_box = $IndentBoxPivot/IndentBox

func _ready() -> void:
	Globals.levelStart.connect(_level_start)
	activate_left.activated.connect(_activated_left)
	activate_right.activated.connect(_activated_right)
	activate_top.activated.connect(_activated_top)
	activate_bottom.activated.connect(_activated_bottom)

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

func move():
	await get_tree().create_timer(0.05).timeout
	if indent_box.has_overlapping_bodies():
		removeTile()
		var nextPostition = position + Vector2(0, -16).rotated(indent_pivot.rotation)
		var tween = create_tween()
		tween.finished.connect(_tween_finished)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", nextPostition, 0.5)

func _tween_finished():
	setTile()

func _activated_left():
	indent_pivot.rotation_degrees = 90
	move()
func _activated_right():
	indent_pivot.rotation_degrees = 270
	move()
func _activated_top():
	indent_pivot.rotation_degrees = 180
	move()
func _activated_bottom():
	indent_pivot.rotation_degrees = 0
	move()
