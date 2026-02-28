extends Node2D

@onready var pause = $CanvasLayer/pause
@onready var death_screen = $CanvasLayer/Death_Screen
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	player.connect("player_died", die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func die():
	death_screen.show()
