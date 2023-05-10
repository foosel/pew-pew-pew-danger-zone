extends BulletEmitter
class_name EnemyBulletEmitter

@export var firing_interval = 0.5
@export var firing_delay = 0.0

var armed = false
var timer


func start() -> void:
	if timer:
		return

	timer = Timer.new()
	timer.set_one_shot(false)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

	if firing_delay:
		timer.set_wait_time(firing_delay)
	else:
		armed = true
		timer.set_wait_time(firing_interval)

	timer.start()


func stop() -> void:
	timer.stop()
	remove_child(timer)


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
