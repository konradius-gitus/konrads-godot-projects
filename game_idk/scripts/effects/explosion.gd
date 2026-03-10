extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$exp_part.emitting = true
	$fine_fx.one_shot = true
	$fine_fx.emitting = true
	$exp_part.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("damagable"):
		body.take_damage(40)


func _on_collisiopn_timer_timeout() -> void:
	$Area2D.monitorable = false
	$Area2D.monitoring = false
