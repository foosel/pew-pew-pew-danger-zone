extends Node2D
class_name Drone

@export var rotate_speed = 3
@export var radius = 64
@export var health = 1
@export var bullet_speed = 200
@export var bullet_steering = 50
@export var min_shot_interval = .7
@export var max_shot_interval = .3
@export var bullet_scene: PackedScene = load("res://scenes/bullet/drone_bullet.tscn") as PackedScene
@export var player: Player


signal died()


@onready var shoot_timer = $ShootTimer as Timer


var center: Vector2
var angle: float = 0


func _ready() -> void:
	center = position
	shoot_timer.wait_time = randf_range(min_shot_interval, max_shot_interval)
	_activate()


func _process(delta) -> void:
	angle += rotate_speed * delta
	position = center + Vector2(sin(angle), cos(angle)) * radius


func shoot() -> void:
	var closest_distance = -1
	var closest_enemy = null
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if not enemy is Enemy:
			continue
		var distance = (enemy.global_position - global_position).length()
		if closest_distance < 0 or distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy as Enemy
		
	if not closest_enemy:
		return

	var direction = (closest_enemy.global_position - global_position).normalized()
	var shot = {
		"scene": bullet_scene,
		"position": player.position + position + direction * 15,
		"velocity": direction * bullet_speed,
		"target": closest_enemy,
		"steering": bullet_steering,
		"rotated": true,
	}	
	player.shots_fired.emit([shot])


func _on_hurtbox_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
		health -= 1
		if health <= 0:
			died.emit()
			_deactivate()


func _on_player_died():
	_deactivate()


func _on_shoot_timer_timeout():
	shoot()


func _on_despawn_timer_timeout():
	_deactivate()


func _activate() -> void:
	Globals.drone_status.emit(true)

	
func _deactivate() -> void:
	Globals.drone_status.emit(false)
	queue_free()
