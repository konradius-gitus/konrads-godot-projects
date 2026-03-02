extends RigidBody2D

var state 
@export var speed_limit = 5000.00
@export var speed= 500.00

var pointer: Vector2


enum AVOID{ground,player,projectiles}
enum STATE{
	EJECT,
	IDLE,
	SEEK,
	PRIMED,
	FOLLOW,
	AVOID
}


func _ready() -> void:
	state= STATE.EJECT


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


func avoid(what: int):
	match what:
		AVOID.player:
			pass
		AVOID.ground:
			pass
		AVOID.projectiles:
			pass


func _on_player_check_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_player_check_body_exited(body: Node2D) -> void:
	state = STATE.IDLE
