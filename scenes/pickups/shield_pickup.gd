extends Pickup


var shield_scene = load("res://scenes/pickups/shield/shield.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)
	
	if Shield.FULL_HEALTH <= 0:
		return
	
	var shield = player.get_tree().get_first_node_in_group("Shield")
	if shield:
		# player already has a shield, reset health
		shield.reset_health()
		return
	
	shield = shield_scene.instantiate() as Shield
	player.died.connect(shield._on_player_died)
	
	player.call_deferred("add_child", shield)
	player.call_deferred("move_child", shield, 0)
