extends PlayerTargetingBehaviour
class_name FollowPlayerBehaviour


@export var offset: Vector2 = Vector2(0, -200)


func _physics_process_behaviour(delta):
	var difference = player.position + offset - enemy.position
	var distance = difference.length()
	var direction = difference.normalized()

	enemy.velocity = direction * min(distance, enemy.speed)

	enemy.move_and_slide()
