extends AnimatedSprite

var walking = false

func _ready():
	pass

#func _on_Button_pressed():
#	play("walk")

func _process(delta):
	if walking:
		position.x += delta * 150

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			play("walk")
			walking = true
