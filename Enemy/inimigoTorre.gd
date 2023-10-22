extends CharacterBody2D

@export var movement_speed = 50.0
@export var hp = 3
@onready var attack = tower()
var death 
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = global_position.direction_to(attack.global_position)
	sprite.play("andar")
	velocity = direction * movement_speed
	move_and_slide()

func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

func tower():
	var torres = get_tree().get_nodes_in_group("torres")
	for at in torres:
		if(at.getdeath() == 0): 
			return at
		else: 
			return get_tree().get_first_node_in_group("player")


func _on_hit_box_body_entered(body):
	sprite.play("atacar")
