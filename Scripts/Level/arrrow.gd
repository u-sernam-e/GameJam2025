extends Area2D

@export var dir: String

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_delete_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dir == "Left":
		rotation = 0
		position += Vector2(-2, 0)
	if dir == "Right":
		rotation = 180
		position += Vector2(2, 0)
	if dir == "Up":
		rotation = -90
		position += Vector2(0, -2)
	if dir == "Down":
		rotation = 90
		position += Vector2(0, 2)


func _on_area_entered(area):
	if area.is_in_group("character"):
		Globals.activate_death = true
		call_deferred("queue_free")
		
func _start_delete_timer():
	await get_tree().create_timer(5).timeout
	call_deferred("queue_free")
