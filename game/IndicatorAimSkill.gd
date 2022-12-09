extends Node2D

const ARROW_DISTANCE = 160
onready var aim_position = $AimPosition

func _ready():
	pass

func _process(delta):
	var curpos = get_local_mouse_position()
	var rad = atan2(curpos.y, curpos.x)
	
	# place the arrow on that angle
	aim_position.position.x = cos(rad) * ARROW_DISTANCE
	aim_position.position.y = sin(rad) * ARROW_DISTANCE
	
	# rotate the arrow accordingly
	aim_position.rotation = rad + PI / 2
