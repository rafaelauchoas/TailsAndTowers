extends RichTextLabel

var text_speed = 0
var box_limit = 900

func _ready():
	pass
	
func _showText():
	if text_speed < box_limit:
		text_speed = text_speed + 0.7
		self.visible_characters = text_speed
	pass

func _process(delta):
	_showText()
	pass

func _on_mudapag_timeout():
	text_speed = 0
