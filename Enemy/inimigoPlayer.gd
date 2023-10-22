extends CharacterBody2D

@export var movement_speed = 50.0
@export var hp = 1
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	sprite.play("andar")
	velocity = direction * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()


func _on_hit_box_body_entered(body):
	sprite.play("atacar") # Replace with function body.
