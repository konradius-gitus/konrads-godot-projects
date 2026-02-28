extends RigidBody2D

@export var speed = 400.0
@export var speed_limit = 500
@export var thrust_constant = 600
var thrust = 50

@export var fuel_tank_max = 1000
var fuel_tank 

signal player_died 
signal tank_empty
signal tank_changed(new_value: float)
signal thrust_changed(new_value: float)

var last_velocity := Vector2.ZERO


func _ready():
	fuel_tank= fuel_tank_max
	thrust = 50


func _physics_process(delta):
	
	if linear_velocity.length() >= speed_limit:
		get_node("../CanvasLayer/speed_warning").show()
	else:
		get_node("../CanvasLayer/speed_warning").hide()
	
	if fuel_tank > 0:
		ship_thrust()
	else:
		tank_empty.emit()
	
	last_velocity = linear_velocity




func ship_thrust():
	
		#calculate throttle
		if Input.is_action_just_pressed("wheel_up") and thrust<100:
			change_thrust(5) 
		
		if Input.is_action_just_pressed("wheel_down") and thrust>0:
			change_thrust(-5)
		
		
		#calculate rotation
		if Input.is_action_pressed("rotate_left"):
			
			apply_torque(-3000)
			change_fuel(-0.12,true)
		
		if Input.is_action_pressed("rotate_right"):
			
			apply_torque(3000)
			change_fuel(-0.12,true)
		
		#calculate movement
		if Input.is_action_pressed("thrust"):
			
			apply_central_force((thrust/100) * thrust_constant *  Vector2.from_angle(deg_to_rad(rotation_degrees -90)))
			change_fuel(-1,false) 
		
		if Input.is_action_pressed("move_left"):
			
			apply_central_force(speed*  Vector2(-1, 0))
			change_fuel(-0.2,true)
		
		if Input.is_action_pressed("move_right"):
			
			apply_central_force(speed*  Vector2(1, 0))
			change_fuel(-0.2,true)
		
		if Input.is_action_pressed("move_up"):
			
			apply_central_force(speed*  Vector2(0, -1))
			change_fuel(-0.2,true)
			
		if Input.is_action_pressed("move_down"):
			
			apply_central_force(speed*  Vector2(0, 1))
			change_fuel(-0.2,true)



func _on_body_entered(body: Node) -> void:
	if last_velocity.length() >= speed_limit:
		die()
		print("ouch")


func change_fuel(change: float,rcs: bool):
	if not rcs:
		fuel_tank += change + change/2 * thrust/100
	else:
		fuel_tank += change
	tank_changed.emit(fuel_tank)

func change_thrust(change: float):
	thrust += change
	thrust_changed.emit(thrust)
	

func die():
	player_died.emit()
	Engine.time_scale = 0
