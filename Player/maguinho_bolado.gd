extends CharacterBody2D

var movement_speed = 100.0
var frame_aux = 0
var time = 0

@onready var healthBar = get_node("%HealthBar")
@onready var timer = get_node("%Timer")

# ATTACKS

var fireball = preload("res://Player/Attack/fire_ball.tscn")
@onready var FireBallTimer = get_node("%FireBallTimer")
@onready var FireBallAATimer = get_node("%FireBallAATimer")
var fireball_attackspeed = 1.5
var fireball_level = 1 # aumenta level se cair torre
var fireball_baseammo = 0
var fireball_ammo = 1

var enemy_close = [] # mira automatico

# UPGRADES

var collected_upgrades = []
var upgrade_options = []
var speed = 0
var spell_size = 0
var additional_attacks = 0

@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

func _ready():
	attack()
	_on_hurt_box_hurt(0)
	
func attack():
	if fireball_level > 0:
		FireBallTimer.wait_time = fireball_attackspeed
		if FireBallTimer.is_stopped():
			FireBallTimer.start()


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

func _on_hurt_box_hurt(damage):
	hp -= damage
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <= 0:
		death()


func death():
#	deathPanel.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	get_tree().change_scene_to_file("res://World/derrota.tscn")

func change_time(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	timer.text = str(get_m,":",get_s)
	if time >= 300:
		get_tree().change_scene_to_file("res://World/vitoria.tscn")


func _on_fire_ball_timer_timeout():
	fireball_ammo += fireball_baseammo + additional_attacks
	FireBallAATimer.start()


func _on_fire_ball_aa_timer_timeout():
#	if fireball_ammo > 0:
	var fireball_attack = fireball.instantiate()
	fireball_attack.position = position
	fireball_attack.target = get_random_target()
	fireball_attack.level = fireball_level
	add_child(fireball_attack)
	fireball_ammo -= 1
	if fireball_ammo > 0:
		FireBallAATimer.start()
	else:
		FireBallAATimer.stop()


func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
