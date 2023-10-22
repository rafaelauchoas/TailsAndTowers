extends Control

func _ready():
	if (MusicControl.musicplaying == 0):
		MusicControl.play_music()
	MusicControl.musicplaying = 1

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://World/tutorial.tscn")

func _on_créditos_pressed():
	get_tree().change_scene_to_file("res://World/creditos.tscn")

func _on_sair_pressed():
	get_tree().quit()

func _on_som_pressed():
	MusicControl.control()
