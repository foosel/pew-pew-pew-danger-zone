extends BulletEmitter
class_name PlayerBulletEmitter

@export var active_during: Array[int] = []


func get_target() -> Node2D:
	var player = owner as Player
	var enemies = get_tree().get_nodes_in_group("Enemy")
	
	var closest_enemy = null
	var closest_distance = -1
	for enemy in enemies:
		var distance = ((enemy as Enemy).position - player.position).length()
		if closest_distance < 0 or distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	
	return closest_enemy
	

func emit_shots(shots: Array) -> void:
	#(owner as Player).shoot(shots)
	pass
