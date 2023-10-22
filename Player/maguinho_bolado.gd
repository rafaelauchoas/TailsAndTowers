extends CharacterBody2D

var movement_speed = 100.0
var frame_aux = 0
@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

func _physics_process(delta): # physics frame
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	# up é negativo e down é positivo não procure entender apenas aceite a magia ok
	# trust me, I've been there before
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	if mov.x > 0:
		sprite.flip_h = false
	elif mov.x < 0:
		sprite.flip_h = true
	
	if mov != Vector2.ZERO:
		if walkTimer.is_stopped():
			# 0, 1, 0, 2, 0, 1, 0, 2...
			# não julgue, fiz assim pq demorei mt mais do que é humanamente aceitável
			if frame_aux != 0:
				sprite.frame = frame_aux
				frame_aux = 0
			elif sprite.frame == 1:
				frame_aux = 2
				sprite.frame = 0
			elif sprite.frame == 2:
				sprite.frame = 0
				frame_aux = 0
			else:
				sprite.frame += 1
			walkTimer.start()	
	
	velocity = mov.normalized() * movement_speed # Sem isso, na diag ele corre mais rapido vrum vrum
	move_and_slide()

