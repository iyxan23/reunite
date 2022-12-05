extends ToolButton

export(Array, NodePath) var otherButtons
var _otherButtons = []

func _ready():
	for button in otherButtons:
		_otherButtons.append(get_node(button))
		
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	for button in _otherButtons:
		button.disabled = true

func _on_mouse_exited():
	for button in _otherButtons:
		button.disabled = false
