extends StaticBody2D

var hp = 10
var maxhp = 10
var death = 0
@onready var sprite = $Sprite2D

func _ready():
	_on_hurt_box_hurt(0)

func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <=5 and hp > 0:
		broke()
	if hp <= 0:
		deadtower()
		
func getdeath():
	return death
		
func broke():
	sprite.frame(1)

func deadtower():
	sprite.frame(2)
	death = 1

