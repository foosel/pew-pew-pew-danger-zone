extends BulletEmitter
class_name EnemyBulletEmitter

@export var firing_interval = 0.5
@export var firing_delay = 0.0

@onready var timer = $Timer as Timer

var armed = false


func start() -> void:
	if firing_delay:
		timer.set_wait_time(firing_delay)
	else:
		armed = true
		timer.set_wait_time(firing_interval)
	timer.start()


func stop() -> void:
	timer.stop()


func get_target() -> Node2D:
	return get_tree().get_first_node_in_group("Player")
	
	
func emit_shots(shots: Array) -> void:
	(owner as Enemy).shoot(shots)


func _on_timer_timeout() -> void:
	if not armed:
		armed = true
		timer.set_wait_time(firing_interval)
		return

	shoot()


func _on_visible_on_screen_notifier_2d_screen_entered():
	start()


func _on_visible_on_screen_notifier_2d_screen_exited():
	stop()
