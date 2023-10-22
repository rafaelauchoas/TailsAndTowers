extends Node2D

var musicplaying = 0
var musicvol = 1

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music():
	$musca.play()

func volume0():
	$musca.volume_db = -80

func volumemax():
	$musca.volume_db = -30

func control():
	if (musicvol == 1):
		volume0()
		musicvol = 0
	else:
		volumemax()
		musicvol = 1
