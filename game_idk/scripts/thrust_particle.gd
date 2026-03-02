extends GPUParticles2D

var can = true


func _ready():
	can = true




func _process(delta):
	if Input.is_action_pressed("thrust")and can:
		emitting = true
	else:
		emitting = false


func _on_player_tank_empty() -> void:
	can = false
