extends CharacterActivateable

@onready var deathZone = $DamageArea/CollisionShape2D
@onready var chestSprite = $ChestSprite
@onready var evilSprite = $EvilSprite

func activate():
	deathZone.disabled = false
	chestSprite.hide()
	evilSprite.show()
