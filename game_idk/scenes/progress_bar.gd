extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = get_node("../../Player").fuel_tank_max
	value = max_value
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#value = get_parent().get_node("/root/Player").get_tank()/5
	#print(value)
	pass


func _on_player_tank_changed(new_value: float) -> void:
	value = new_value
