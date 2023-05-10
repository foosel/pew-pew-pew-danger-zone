extends Pickup


func pickup(player: Player) -> void:
	super.pickup(player)
	player.add_points(1)
