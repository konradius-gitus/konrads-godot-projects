extends RigidBody2D

class_name npc_ship

var explosion = preload("res://scenes/explosion.tscn")

#  Shield variables
var hp = 100
var shield_charge = 1
var shield_strength = 100
var shield_force 

# Weapon variables
var weapon_cooldown = 1
var weapon
var weapon_damage = 30
var goal = Vector2.ZERO

# Movement variables
var accuracy_threshhold = 20
var direction
@export var thrust_max = 600
@export var thrust_min = 1
var thrust
var max_velocity = 5000
var break_distance: float = 0.0
var speed = 0.0

var state = 0

enum STATE{ 
	IDLE,
	ALERT,
	ENGAGING,
	FLEE,
	APPROACH,
	RECOVER,
	ATTACK
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	speed = linear_velocity.length()
	
	
	match state:
		
		STATE.IDLE:
			idle()
		
		STATE.ALERT:
			alert()
		
		STATE.ENGAGING:
			engaging()
		
		STATE.FLEE:
			flee()
		
		STATE.APPROACH:
			approach()
		
		STATE.RECOVER:
			recover()
		
		STATE.ATTACK:
			attack()



func idle():
	pass

func alert():
	pass

func engaging():
	pass

func flee():
	pass

func approach():
	pass

func recover():
	pass

func attack():
	pass

func take_damage(dmg: int):
	hp -= dmg
	if hp <= 0:
		die()

func die():
	var instance = explosion.instantiate()
	instance.global_position = global_position
	get_parent().add_child(instance)
	queue_free()
	


func move():
	break_distance = speed / 2 * thrust_max
	direction = (goal - global_position).normalized()
	
	if (goal - global_position).length() <= accuracy_threshhold:
		if speed >= 4:
			thrust = -direction * (thrust_max * 1/speed)
		else:
			
			return 
	else:
		thrust = (direction * thrust_max)-(0.8 * linear_velocity)
		apply_central_force(thrust)
		


func slow_down():
	pass
