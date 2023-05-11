extends Node2D
class_name BulletManager


func spawn_bullets(bullets: Array) -> void:
	var rotated: bool
	var steering: float
	var target: Node2D

	for b in bullets:
		if "scene" not in b or "position" not in b or "velocity" not in b:
			continue
		
		if "rotated" in b:
			rotated = b["rotated"]
		else:
			rotated = false
			
		if "steering" in b:
			steering = b["steering"]
		else:
			steering = 0
		
		if "target" in b:
			target = b["target"]
		else:
			target = null

		spawn_bullet(b["scene"], b["position"], b["velocity"], rotated, target, steering)


func spawn_bullet(scene: PackedScene, pos: Vector2, velocity: Vector2, rotated: bool = false, target: Node2D = null, steering: float = 0) -> void:
	var bullet = scene.instantiate() as Bullet

	if rotated:
		var angle = velocity.angle() - deg_to_rad(90)
		bullet.rotate(angle)

	bullet.position = pos
	bullet.linear_velocity = velocity
	bullet.target = target
	bullet.steering = steering
	add_child(bullet)
