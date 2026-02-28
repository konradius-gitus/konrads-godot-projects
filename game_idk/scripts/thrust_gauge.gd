extends Label

var percent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	percent = get_node("../../Player").thrust
	text = "%.1f" % percent + "%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_thrust_changed(new_value: float) -> void:
	text = "%.1f" % new_value + "%"
