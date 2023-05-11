extends Pickup

var bomb_scene = load("res://scenes/pickups/bomb/bomb.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)

	if player.get_tree().get_first_node_in_group("Bomb"):
		# player already has a bomb
		return
	
	var bomb = bomb_scene.instantiate() as Bomb
	player.died.connect(bomb._on_player_died)
	bomb.exploded.connect(player._on_bomb_exploded)

	player.call_deferred("add_child", bomb)
	player.call_deferred("move_child", bomb, 1) # add after shadow

