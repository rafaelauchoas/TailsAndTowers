extends Control
#export(Array,String,FILE) var dialog

var dialog = [
	'Numa noite, um implacável mago, entrou numa partida de truco contra Ronaldo, o rato. O mago queria se provar para Ronaldo, e por isso resolveu apostar seu precioso óculos. Porém foi surpreendido por um zap de Ronaldo e foi derrotado. Mas o mago, é implacável. Antes de ir embora o mago descobriu que Ronaldo havia trapaceado, então lançou um feitiço contra ele.',
	'Ronaldo, após desviar do ataque, revelou-se o grande rei dos ratos de Roma e ordenou que seus soldados atacassem o mago, que teve que bater em retirada estratégica. Mas o mago é implacável, ele direcionou sua energia vital para suas cinco torres no campo, e com isso tornou-se temporariamente imortal, obrigando os ratos a destruírem suas torres se quiserem acabar com ele.',]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()
	
func _process(delta):
	pass

func load_dialog():
	$mudapag.start()
	if dialog_index <= dialog.size():
		$introTexto.bbcode_text = dialog[dialog_index]

func _on_Prox_pressed():
	if dialog_index < dialog.size()-1:
		dialog_index += 1
	elif dialog_index == dialog.size()-1:
		get_tree().change_scene_to_file("res://World/world.tscn")
	load_dialog()

func _on_Pular_pressed():
	get_tree().change_scene_to_file("res://World/world.tscn")

func  _on_Voltar_pressed():
	dialog_index -= 1
	if(dialog_index==-1):
		get_tree().change_scene_to_file("res://World/menu.tscn")
	else:
		load_dialog()
	
func _on_sair_pressed():
	get_tree().change_scene_to_file("res://World/menu.tscn")
