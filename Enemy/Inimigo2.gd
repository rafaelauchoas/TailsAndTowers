extends CharacterBody2D

@export var movement_speed = 50.0
@export var hp = 1
@onready var player = get_tree().get_first_node_in_group("torres")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
