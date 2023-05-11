extends Pickup

var drone_scene = load("res://scenes/pickups/drone/drone.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)

	if player.get_tree().get_first_node_in_group("Drone"):
		# player already has a drone
		return
	
	var drone = drone_scene.instantiate() as Drone
	drone.player = player
	player.died.connect(drone._on_player_died)
	drone.died.connect(player._on_drone_died)

	player.call_deferred("add_child", drone)
	player.call_deferred("move_child", drone, 1) # add after shadow

