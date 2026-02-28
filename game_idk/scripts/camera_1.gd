extends Camera2D

@onready var player = $"/root/World/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	position = player.position
	
	if Input.is_action_pressed("shift"):
		if Input.is_action_just_pressed("wheel_up") and zoom.x <= 3:
			zoom *= 1.1
		if Input.is_action_just_pressed("wheel_down")and zoom.x >= 0.7:
			zoom *= 0.9
		
