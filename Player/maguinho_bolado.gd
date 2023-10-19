extends CharacterBody2D

var movement_speed = 100.0

func _physics_process(delta): # physics frame
	movement() 


func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	# up é negativo e down é positivo não procure entender apenas aceite a magia ok
	# trust me, I've been there before
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * movement_speed # Sem isso, na diag ele corre mais rapido vrum vrum
	move_and_slide()

