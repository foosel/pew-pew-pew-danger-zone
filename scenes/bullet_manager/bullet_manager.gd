extends Node2D
class_name BulletManager


func spawn_bullets(scene: PackedScene, bullet_data: Array, target: Node2D = null) -> void:
	var steering: float
	for b in bullet_data:
		if "steering" in b:
			steering = b["steering"]
		else:
			steering = 0
		spawn_bullet(scene, b["position"], b["velocity"], steering, target)


func spawn_bullet(scene: PackedScene, pos: Vector2, velocity: Vector2, steering: float, target: Node2D = null) -> void:
	var bullet = scene.instantiate() as Bullet
	bullet.position = pos
	bullet.linear_velocity = velocity
	bullet.steering = steering
	bullet.target = target
	add_child(bullet)
