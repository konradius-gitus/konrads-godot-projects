extends npc_ship


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goal = global_position +Vector2(50,-200)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func alert():
	#check here for player hp, gear, lvl or such differences and decide if aggro, neutral oder appraoch for interaction
	state = STATE.ENGAGING

func engaging():
	move()
	

func _on_aggro_range_body_entered(body: Node2D) -> void:
	state = STATE.ALERT
	
