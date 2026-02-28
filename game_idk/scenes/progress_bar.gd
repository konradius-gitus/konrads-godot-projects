extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 100.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#value = get_parent().get_node("/root/Player").get_tank()/5
	#print(value)
	pass
