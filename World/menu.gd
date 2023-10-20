extends Control

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://World/tutorial.tscn")

func _on_créditos_pressed():
	get_tree().change_scene_to_file("res://World/creditos.tscn")

func _on_sair_pressed():
	get_tree().quit()
