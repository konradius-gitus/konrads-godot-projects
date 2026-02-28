extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("escape"):
		if Engine.time_scale == 0:
			Engine.time_scale = 1
			hide()
		else:
			Engine.time_scale = 0
			show()


func _on_button_pressed() -> void:
	Engine.time_scale = 1
	hide()


func _on_button_2_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_3_pressed() -> void:
	get_tree().quit()
