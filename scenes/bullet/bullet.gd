extends RigidBody2D
class_name Bullet


var steering = 50.0
var target: Node2D


func _integrate_forces(_state):
	if not target:
		return
	
	var direction = (target.position - position).normalized()
	apply_force(direction * steering)


func explode() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
