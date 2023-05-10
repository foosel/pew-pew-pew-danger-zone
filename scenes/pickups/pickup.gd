extends RigidBody2D
class_name Pickup


@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var despawn_timer = $DespawnTimer as Timer


func _ready() -> void:
	# randomize hover animation
	var animation = animation_player.get_animation("hover")
	var pos = randf_range(0, animation.length)
	
	animation_player.assigned_animation = "hover"
	animation_player.seek(pos, true)
	animation_player.play()


func pickup(_player: Player) -> void:
	queue_free()


func _on_despawn_timer_timeout():
	print("Pickup " + str(self) + " despawned")
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	despawn_timer.stop()


func _on_visible_on_screen_notifier_2d_screen_exited():
	despawn_timer.start()
