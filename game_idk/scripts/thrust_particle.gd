extends GPUParticles2D

var can = true

# Called when the node enters the scene tree for the first time.
func _ready():
	can = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_pressed("thrust")and can:
		emitting = true
	else:
		emitting = false


func _on_player_tank_empty() -> void:
	can = false
