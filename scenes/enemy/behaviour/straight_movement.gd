extends Behaviour
class_name StraightMovementBehaviour


@export var angle: float = 0
@export var scroll_along: bool = true


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
	enemy.velocity = direction * enemy.speed
	if scroll_along:
		enemy.velocity += Globals.scroll_speed * Vector2.UP
	enemy.move_and_slide()
