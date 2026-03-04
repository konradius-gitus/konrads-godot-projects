extends npc_ship


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func alert():
	pass


func _on_aggro_range_body_entered(body: Node2D) -> void:
	state = STATE.ALERT
