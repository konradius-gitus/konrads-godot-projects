extends RigidBody2D

class_name npc_ship

var explosion = preload("res://scenes/explosion.tscn")

var hp = 100
var shield_charge = 1
var shield_strength = 100
var shield_force 

var weapon_cooldown = 1
var weapon
var weapon_damage = 30


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
func _process(delta: float) -> void:
	
	
	
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
	
