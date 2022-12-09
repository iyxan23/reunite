extends Actor

const FLOOR_DETECT_DISTANCE = 20.0

onready var platform_detector = $GroundRayCast
onready var character_animation = $CharacterAnimation

func _ready():
	pass

func _physics_process(_delta):
	var direction = get_direction(speed)
	_velocity = calculate_move_velocity(_velocity, direction, speed)

	var snap_vector = Vector2.ZERO
	if direction.y == 0.0:
		snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE

	var is_on_platform = platform_detector.is_colliding()
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
	)

	# When the character’s direction changes, we want to to scale the Sprite accordingly to flip it.
	# This will make Robi face left or right depending on the direction you move.
	if direction.x != 0:
		if direction.x > 0:
			character_animation.flip_h = false
		else:
			character_animation.flip_h = true

	var animation = get_new_animation()
	if animation != character_animation.animation:
		character_animation.play(animation)


func get_direction(speed):
	var hor = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if Input.is_physical_key_pressed(KEY_SHIFT):
		hor *= 1.5
		
	return Vector2(
		hor,
		-1 if is_on_floor() and Input.is_action_just_released("jump") else 0
	)

func calculate_move_velocity(
		linear_velocity,
		direction,
		speed
	):

	var velocity = linear_velocity
	velocity.x = speed.x * direction.x

	if direction.y != 0.0:
		velocity.y = speed.y * direction.y

	return velocity

func get_new_animation():
	var animation_new = ""
	if is_on_floor():
		if abs(_velocity.x) > 0.1:
			if Input.is_physical_key_pressed(KEY_SHIFT):
				animation_new = "run"
			else:
				animation_new = "walk"
		else:
			animation_new = "idle"
	else:
		if _velocity.y > 0:
			animation_new = "fall"
		else:
			animation_new = "jump"
	return animation_new
