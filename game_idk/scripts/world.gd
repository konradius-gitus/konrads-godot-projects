extends Node2D

@onready var pause = $CanvasLayer/pause
@onready var death_screen = $CanvasLayer/Death_Screen
@onready var player = $Player



var rocket_scene = preload("res://scenes/rocket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	player.connect("player_died", die)
	player.connect("rocket_spawn", spawn_rocket)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("aim_lock"):
		rocket_aim_lock()
	


func die():
	death_screen.show()

func spawn_rocket(coords: Vector2, angle: float):
	var instance
	instance = rocket_scene.instantiate()
	instance.global_position= coords
	instance.global_rotation = angle
	add_child(instance)

func rocket_aim_lock():
	$rocket_aim.global_position = get_global_mouse_position()
	$rocket_aim.show()
	$aim_timer.start()

func _on_aim_timer_timeout() -> void:
	$rocket_aim.hide()

func get_player_position():
	return player.global_position
