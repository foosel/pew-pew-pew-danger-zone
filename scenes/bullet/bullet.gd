extends RigidBody2D
class_name Bullet

@export var damage: int = 1
@export var target: Node2D
@export var steering: float = 50


func _integrate_forces(_state):
	if not target:
		return
	
	var direction = (target.global_position - global_position).normalized()
	apply_central_force(direction * steering)

func show_trail(direction: Vector2) -> void:
	$Trail.show_up(direction.normalized() * 50)

func explode() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_despawn_timer_timeout():
	queue_free()
