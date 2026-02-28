extends Node2D

signal RCS1
signal RCS2
signal RCS3

signal RCS4
signal RCS5
signal RCS6

signal RCS1off
signal RCS2off
signal RCS3off

signal RCS4off
signal RCS5off
signal RCS6off


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("move_down"):
		call_rcs(find_direction(3))  #activate the rcs needed to move down
	
	if Input.is_action_just_pressed("move_up"):
		call_rcs(find_direction(1))
	
	if Input.is_action_just_pressed("move_left"):
		call_rcs(find_direction(4))
	
	if Input.is_action_just_pressed("move_right"):
		call_rcs(find_direction(2))

	if Input.is_action_just_released("move_down"):
		off_rcs(find_direction(3))  
	
	if Input.is_action_just_released("move_up"):
		off_rcs(find_direction(1))
	
	if Input.is_action_just_released("move_left"):
		off_rcs(find_direction(4))
	
	if Input.is_action_just_released("move_right"):
		off_rcs(find_direction(2))
	
	if Input.is_action_just_pressed("rotate_left"):
		RCS6.emit()
		RCS3.emit()
	
	if Input.is_action_just_released("rotate_left"):
		RCS6off.emit()
		RCS3off.emit()
	
	if Input.is_action_just_pressed("rotate_right"):
		RCS1.emit()
		RCS4.emit()
	
	if Input.is_action_just_released("rotate_right"):
		RCS1off.emit()
		RCS4off.emit()
	
func rcs_direction():  #returns the orientation of rcs
	var pointer = Vector2.from_angle(global_rotation).orthogonal()
	
	if abs(pointer.y) > abs(pointer.x):
		if pointer.y < 0:
			#print(1)
			return [3, 4, 1, 1, 2, 3] # case 1
		else:
			#print(3)
			return [1, 2, 3, 3, 4, 1] # case 3
	
	if pointer.x > 0:
			#print(2)
			return[4, 1, 2, 2, 3, 4] #case 2
	else:
			#print(4)
			return [2, 3, 4, 4, 1, 2] #case 4

func find_direction(x):  # finds the index of the rcs to activate
	return rcs_direction().find(x)

func call_rcs(x):   # emits the signal for the rcs
	match x:
		0: 
			RCS1.emit()
			RCS6.emit()
		
		1:
			RCS2.emit()
		
		2:
			RCS3.emit()
			RCS4.emit()
		
		4:
			RCS5.emit()
			
func off_rcs(x):   # emits the signal for the rcs to turn off
	match x:
		0: 
			RCS1off.emit()
			RCS6off.emit()
		
		1:
			RCS2off.emit()
		
		2:
			RCS3off.emit()
			RCS4off.emit()
		
		4:
			RCS5off.emit()
