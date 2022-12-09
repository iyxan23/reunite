extends Node2D

onready var camera = $Camera2D
onready var camera_animation_player = $Camera2D/AnimationPlayer
onready var player = $Player

enum PlayerStatus { AIMING, IDLE }
var player_status = PlayerStatus.IDLE

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("skill_1"):
		if player_status == PlayerStatus.IDLE:
			player_status = PlayerStatus.AIMING

			var aim_indicator = load("res://game/IndicatorAimSkill.tscn").instance()
			aim_indicator.position.y = -55 # set the offset
			player.add_child(aim_indicator)

		elif player_status == PlayerStatus.AIMING:
			player_status = PlayerStatus.IDLE
			player.get_node("IndicatorAimSkill").queue_free()

	elif event.is_action_pressed("shoot"):
		if player_status == PlayerStatus.AIMING:
			var aim_indicator = player.get_node("IndicatorAimSkill") as Node2D
			var bullet = load("res://game/TestBullet.tscn").instance() as RigidBody2D
			bullet.add_force(
				player.global_position,
				Vector2(
					360 - cos(aim_indicator.rotation) * 5,
					360 - sin(aim_indicator.rotation) * 5
				)
			)
			
			bullet.position = (aim_indicator.get_node("AimPosition") as Node2D).global_position
			add_child(bullet)
			
			player_status = PlayerStatus.IDLE
			player.get_node("IndicatorAimSkill").queue_free()

func _process(delta):
	# make the camera follow the player
	camera.position.x = player.position.x
	camera.position.y = player.position.y

func zoomIn():
	camera_animation_player.play("zoom_in")

func zoomOut():
	camera_animation_player.play("zoom_out")
