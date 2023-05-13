extends Behaviour
class_name CircleTargetBehaviour


@export var target: Node2D
@export var radius = 64
@export var start_angle = 0
@export var rotate_speed = 3


var angle = 0


func _ready() -> void:
	super()
	angle = deg_to_rad(start_angle)


func _physics_process_behaviour(delta):
	if not is_instance_valid(enemy) or not is_instance_valid(target):
		return false
	angle = wrap(angle + rotate_speed * delta, 0, 2 * PI)
	enemy.global_position = target.global_position + Vector2(sin(angle), cos(angle)) * radius
	return true
