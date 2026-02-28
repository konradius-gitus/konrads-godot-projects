extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var curve = $Path2D.curve
	var polygon = $CollisionPolygon2D.polygon
	$Polygon2D.polygon = polygon
	$Polygon2D.position = $CollisionPolygon2D.position
	#$CollisionPolygon2D.polygon = polygon
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
