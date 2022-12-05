extends Label

func _ready():
	connect("gui_input", self, "_on_story_mode_gui_input")
	connect("mouse_entered", self, "_on_story_mode_mouse_entered")
	print("hello world :)")


# why do these signals dont work!??!?!?! i absolutely have no clue
func _on_story_mode_gui_input(event):
	print("gui input")
	print(event)
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		print("Clicked")


func _on_story_mode_mouse_entered():
	print("entered")
