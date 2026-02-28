extends RigidBody2D

@export var speed = 400.0
@export var speed_limit = 500
var thrust: float = 400.0


var fuel_tank_max = 500
var fuel_tank = 500

signal player_died 
signal tank_empty
signal tank_changed(new_value: float)

func _ready():
	fuel_tank= 500


func _physics_process(delta):
	
	if fuel_tank > 0:
		
		
		#calculate throttle
		if Input.is_action_just_pressed("wheel_up") and thrust<800 and Input.is_action_pressed("shift"):
			pass
		else:
			thrust += 20
		
		if Input.is_action_just_pressed("wheel_down") and thrust>0 and Input.is_action_pressed("shift"):
			pass
		else:
			thrust -= 20
		
		
		#calculate rotation
		if Input.is_action_pressed("rotate_left"):
			#angular_velocity += 0.003
			apply_torque(-3000)
		
		if Input.is_action_pressed("rotate_right"):
			#angular_velocity -= 0.003
			apply_torque(3000)
		
		
		
		#calculate movement
		if Input.is_action_pressed("thrust"):
			#velocity += pointer * delta * thrust
			apply_central_force(thrust*  Vector2.from_angle(deg_to_rad(rotation_degrees -90)))
			change_fuel(-1) 
		
		if Input.is_action_pressed("move_left"):
			#velocity.x += -speed * delta 
			apply_central_force(speed*  Vector2(-1, 0))
		
		if Input.is_action_pressed("move_right"):
			#velocity.x += speed * delta 
			apply_central_force(speed*  Vector2(1, 0))
		
		if Input.is_action_pressed("move_up"):
			#velocity.y += -speed * delta 
			apply_central_force(speed*  Vector2(0, -1))
		
		if Input.is_action_pressed("move_down"):
			#velocity.y += speed * delta 
			apply_central_force(speed*  Vector2(0, 1))
	else:
		tank_empty.emit()
	#print(linear_velocity.length())
	
	#velocity = get_real_velocity()


func _on_body_entered(body: Node) -> void:
	if linear_velocity.length() >= speed_limit:
		die()
		print("ouch")


func change_fuel(change: float):
	fuel_tank += change
	tank_changed.emit(fuel_tank)


func get_tank():
	return(fuel_tank)

func die():
	player_died.emit()
	Engine.time_scale = 0
