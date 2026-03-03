extends RigidBody2D

class_name npc_ship

var hp = 100
var shield_charge = 1
var shield_strength = 100
var shield_force 

var weapon_cooldown = 1
var weapon
var damage = 30


var state = 0

enum STATE{ 
	IDLE,
	ALERT,
	ENGAGING,
	FLEE,
	APPROACH,
	RECOVER
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

func 
