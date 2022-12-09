extends Node2D

onready var camera = $Camera2D
onready var camera_animation_player = $Camera2D/AnimationPlayer
onready var player = $Player

func _ready():
	pass

func _process(delta):
	# make the camera follow the player
	camera.position.x = player.position.x
	camera.position.y = player.position.y

func zoomIn():
	camera_animation_player.play("zoom_in")

func zoomOut():
	camera_animation_player.play("zoom_out")
