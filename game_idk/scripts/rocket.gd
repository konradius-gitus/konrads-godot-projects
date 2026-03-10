extends RigidBody2D

var state 
@export var speed_limit = 8000.00
@export var speed= 500.00
var far_enough = false

@export var angular_velocity_limit = 50.0

var pointer: Vector2

var last_velocity := Vector2.ZERO
@onready var explosion = preload("res://scenes/explosion.tscn")

enum AVOID{ground,player,projectiles}
enum STATE{
	EJECT,
	IDLE,
	SEEK,
	PRIMED,
	FOLLOW,
	AVOID
}

signal rocket_explosion(Vector2)

func _ready() -> void:
	state= STATE.EJECT
	$life_timer.start()
	#apply_central_impulse(500)
	apply_central_impulse(Vector2.UP.rotated(rotation)*1000)


func _physics_process(delta: float) -> void:
	
	#pointer = Vector2.from_angle(deg_to_rad(rotation_degrees -90))
	
	
	match state:
		
		STATE.EJECT:
			eject()
		
		STATE.IDLE:
			idle()
		
		STATE.SEEK:
			seek(delta)
		
		STATE.PRIMED:
			primed()
		
		STATE.FOLLOW:
			follow()
	
	check_collision()
	last_velocity = linear_velocity

func follow():
	if linear_velocity.length() <= speed_limit:
		apply_central_force(pointer*speed)
		avoid(AVOID.player)
		avoid(AVOID.ground)

func primed():
	pass



func seek(delta: float):
	#steer_to_point(get_node("/root/World/rocket_aim").global_position, delta)
	var goal = get_node("/root/World/rocket_aim").global_position
	var direction = (goal - global_position).normalized()
	var goal_vector: Vector2 = (direction*linear_velocity.length())-direction
	rotate_rocket(rad_to_deg(goal_vector.angle()))

func idle():
	if Input.is_action_just_pressed("aim_lock"):
		state = STATE.SEEK

func eject():
	
	if far_enough:
		break_rapidly()
		state = STATE.SEEK
	else:apply_central_force(Vector2.UP.rotated(rotation)*500)

func check_collision():
	pass

func avoid(what: int):
	match what:
		AVOID.player:
			pass
		AVOID.ground:
			pass
		AVOID.projectiles:
			pass

func _on_body_entered(body: Node) -> void:
	if last_velocity.length()>= 50:
		explode()

func explode():
	#rocket_explosion.emit(global_position)
	var instance
	instance = explosion.instantiate()
	instance.global_position= global_position
	get_parent().add_child(instance)
	queue_free()

func _on_life_timer_timeout() -> void:
	explode()



func rotate_rocket(goal_angle: float):
	var goal_vector = Vector2.from_angle(goal_angle)
	if abs(rad_to_deg(get_angle_to(goal_vector))) < 1:
		if  angular_velocity < 1:
			return


func break_rapidly():
	pass

func steer_to_point(target_position: Vector2, delta):  #latenight chatgpt
	pass
	#var to_target = target_position - global_position
	#var distance = to_target.length()
	#
	#if distance < 5:
		#STATE.IDLE
	#
	#var desired_direction = to_target.normalized()
	#var desired_angle = desired_direction.angle()
	#var angle_diff = wrapf(desired_angle - rotation, -PI, PI)
#
	## Drehung (PD-Controller light)
	#var torque = angle_diff * 20.0 - angular_velocity * 5.0
	#apply_torque(torque)
#
	## Vorwärtsvektor
	#var forward = Vector2.RIGHT.rotated(rotation)

	## Bremsberechnung
	#var speed_ = linear_velocity.length()
	#var max_acc = 400.0
	#var braking_distance = (speed_ * speed_) / (2.0 * max_acc)
#
	#if abs(angle_diff) < 0.3:
		#if braking_distance < distance:
			#apply_central_force(forward * max_acc)
		#else:
			#apply_central_force(-forward * max_acc)



func _on_player_check_body_exited(body: Node2D) -> void:
	far_enough = true

func _on_target_check_body_entered(body: Node2D) -> void:
	#state = STATE.PRIMED
	pass
