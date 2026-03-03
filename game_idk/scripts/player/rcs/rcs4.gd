extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_particle_controller_rcs_4():
	emitting = true


func _on_particle_controller_rcs_4_off():
	emitting = false
