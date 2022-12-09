extends Node2D

export(Array, NodePath) var zoomAreas
var _zoomAreas = []

onready var camera = $Camera2D
onready var player = $Player

func _ready():
	for path in zoomAreas:
		var zoomArea = get_node(path) as Area2D
		$Area2D.connect("body_shape_entered", self, "zoomIn")
		$Area2D.connect("body_shape_exited", self, "zoomOut")

func _process(delta):
	camera.position.x = player.position.x
	camera.position.y = player.position.y

func zoomIn():
	print("zoom in")
	camera.zoom.x = .75
	camera.zoom.y = .75

func zoomOut():
	print("zoom out")
	camera.zoom.x = 1
	camera.zoom.y = 1
