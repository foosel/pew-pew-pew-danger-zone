extends Pickup


var shield_scene = load("res://scenes/pickups/shield/shield.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)
	
	if player.get_tree().get_first_node_in_group("Shield"):
		# player already has a shield
		return
	
	var shield = shield_scene.instantiate()
	player.add_child(shield)
	player.move_child(shield, 0)
	
