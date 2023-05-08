extends Node2D
class_name BulletEmitter

@export var bullet_scene: PackedScene = load("res://scenes/bullet/enemy_bullet.tscn")
@export var firing_interval = 0.5
@export var firing_delay = 0.0
@export var homing = false


var bullet_pattern: BulletPattern
var armed = false
var timer


func _ready() -> void:
	for child in get_children():
		if child is BulletPattern:
			bullet_pattern = child
			break


func start() -> void:
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


func shoot() -> void:
	if not bullet_pattern:
		return

	var shots = bullet_pattern.generate_shots(owner.position + position)
	if shots:
		(owner as Enemy).shoot(bullet_scene, shots, homing)


func _on_timer_timeout() -> void:
	if not armed:
		armed = true
		timer.set_wait_time(firing_interval)
		return

	shoot()


func _on_visible_on_screen_enabler_2d_screen_entered():
	start()


func _on_visible_on_screen_enabler_2d_screen_exited():
	stop()
