extends CharacterBody2D

@export var speed = 300.0
@export var thrust = 500.0
@export var gravity = 200.0

var angular_velocity_left = 0.0
var angular_velocity_right = 0.0
var angular_velocity = 0.0


func _physics_process(delta):

	# -------------------------
	# THROTTLE SYSTEM
	# -------------------------
	if Input.is_action_just_pressed("wheel_up") and thrust < 1500:
		if not Input.is_action_pressed("shift"):
			thrust += 20
	
	if Input.is_action_just_pressed("wheel_down") and thrust > 0:
		if not Input.is_action_pressed("shift"):
			thrust -= 20


	# -------------------------
	# ROTATION
	# -------------------------
	if Input.is_action_pressed("rotate_left") and angular_velocity_left < 4:
		angular_velocity_left += 4 * delta
	
	if Input.is_action_pressed("rotate_right") and angular_velocity_right < 4:
		angular_velocity_right += 4 * delta
	
	angular_velocity = angular_velocity_right - angular_velocity_left
	
	# Framerate-unabhängige Rotation
	rotate(angular_velocity * delta)
	
	# Rotations-Dämpfung
	angular_velocity_left *= 0.95
	angular_velocity_right *= 0.95


	# -------------------------
	# THRUST RICHTUNG
	# -------------------------
	var pointer = Vector2.UP.rotated(rotation)


	# -------------------------
	# BEWEGUNG
	# -------------------------

	# Gravity (immer aktiv)
	velocity.y += gravity * delta

	# Haupttriebwerk
	if Input.is_action_pressed("thrust"):
		velocity += pointer * thrust * delta

	# Manuelle Bewegung (optional)
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed * delta
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed * delta
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed * delta
	
	if Input.is_action_pressed("move_down"):
		velocity.y += speed * delta


	# -------------------------
	# BEWEGUNG AUSFÜHREN
	# -------------------------
	move_and_slide()


	# -------------------------
	# DEBUG
	# -------------------------
	print("Velocity: ", velocity.length())
