extends BulletPattern


@export_range(0, 360) var angle: float = 180.0
@export var distance: float = 0.0


func generate_shots(pos: Vector2) -> Array:
	var direction = Vector2.UP.rotated(deg_to_rad(angle))
	return [
		{
			"position": pos + distance * direction, 
			"velocity": direction * speed,
			"steering": steering
		}
	]
