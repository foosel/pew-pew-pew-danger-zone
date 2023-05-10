extends PlayerTargetingBehaviour
class_name FollowPlayerBehaviour


@export var offset: Vector2 = Vector2(0, -200)


func _physics_process_behaviour(_delta):
	var target = player.position + offset
	target.x = clamp(target.x, Globals.visible_viewport.position.x, Globals.visible_viewport.position.x + Globals.visible_viewport.size.x)
	target.y = clamp(target.y, Globals.visible_viewport.position.y, Globals.visible_viewport.position.y + Globals.visible_viewport.size.y)
	
	var difference = target - enemy.position
	var distance = difference.length()
	var direction = difference.normalized()

	enemy.velocity = direction * min(distance, enemy.speed)

	enemy.move_and_slide()
