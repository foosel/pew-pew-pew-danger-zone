extends BulletPattern


@export var segments = 12
@export var distance = 0
@export var offset_angle_per_firing = 0


var offset_angle = 0


func generate_shots(pos: Vector2) -> Array:
	var shots = []

	var segment = 360.0 / segments
	for x in range(segments):
		var angle = deg_to_rad(-offset_angle + x * -segment)
		var direction = Vector2.UP.rotated(angle)

		shots.append({
			"position": pos + direction * distance, 
			"velocity": direction * speed, 
			"steering": steering
		})
	
	offset_angle += offset_angle_per_firing
	return shots
