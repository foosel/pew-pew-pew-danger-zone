extends CharacterBody2D
class_name Drone

@export var rotate_speed = 3
@export var radius = 64
@export var health = 1
@export var bullet_scene: PackedScene = load("res://scenes/bullet/drone_bullet.tscn") as PackedScene

@export var min_shot_interval = 1
@export var max_shot_interval = 1.5

@onready var timer = $Timer as Timer

signal shots_fired(bullet_scene: PackedScene, shots: Array)
signal died(drone: Drone)

var center: Vector2
var angle: float = 0


func _ready() -> void:
	center = position
	timer.wait_time = randf_range(min_shot_interval, max_shot_interval)


func _process(delta) -> void:
	angle += rotate_speed * delta
	position = center + Vector2(sin(angle), cos(angle)) * radius


func shoot() -> void:
	print("Drone shot!")


func _on_timer_timeout():
	shoot()


func _on_hurtbox_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
		health -= 1
		if health <= 0:
			died.emit(self)
			queue_free()
