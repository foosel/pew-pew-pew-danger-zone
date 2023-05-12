extends Pickup

var drone_scene = load("res://scenes/pickups/drone/drone.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)

	var drone = player.get_tree().get_first_node_in_group("Drone")
	if drone:
		# player already has a drone, reset its timeout
		drone.reset_timeout()
		return
	
	drone = drone_scene.instantiate() as Drone
	drone.player = player
	player.died.connect(drone._on_player_died)
	drone.died.connect(player._on_drone_died)

	player.call_deferred("add_child", drone)
	player.call_deferred("move_child", drone, 1) # add after shadow

