extends Area2D

@export var direction: String

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_delete_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if direction == "Left":
		position += Vector2(-2, 0)
	if direction == "Right":
		position += Vector2(2, 0)


func _on_area_entered(area):
	if area.is_in_group("character"):
		call_deferred("queue_free")
		
func _start_delete_timer():
	await get_tree().create_timer(5).timeout
	call_deferred("queue_free")
