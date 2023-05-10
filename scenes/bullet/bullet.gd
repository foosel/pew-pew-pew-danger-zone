extends RigidBody2D
class_name Bullet


func explode() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
