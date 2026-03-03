extends RigidBody2D

var state 
@export var speed_limit = 8000.00
@export var speed= 500.00

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


func _physics_process(delta: float) -> void:
	
	pointer = Vector2.from_angle(deg_to_rad(rotation_degrees -90))
	
	
	match state:
		
		STATE.EJECT:
			eject()
		
		STATE.IDLE:
			idle()
		
		STATE.SEEK:
			seek()
		
		STATE.PRIMED:
			primed()
		
		STATE.FOLLOW:
			follow()
	
	check_collision()
	last_velocity = linear_velocity

func follow():
	pass

func primed():
	pass

func seek():
	pass

func idle():
	pass

func eject():
	if linear_velocity.length() <= speed_limit:
		apply_central_force(pointer*speed)
		avoid(AVOID.player)
		avoid(AVOID.ground)


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
	rocket_explosion.emit(global_position)
	var instance
	instance = explosion.instantiate()
	instance.global_position= global_position
	get_parent().add_child(instance)
	queue_free()

func _on_life_timer_timeout() -> void:
	explode()
