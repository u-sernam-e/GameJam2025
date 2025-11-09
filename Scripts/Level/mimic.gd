extends CharacterActivateable

@onready var deathZone = $DamageArea/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func activate():
	animated_sprite_2d.play("attack")
	deathZone.disabled = false
