extends Pickup

var drone_scene = load("res://scenes/pickups/drone/drone.tscn")


func pickup(player: Player) -> void:
	super.pickup(player)

	if player.get_tree().get_first_node_in_group("Drone"):
		# player already has a drone
		return
	
	var drone = drone_scene.instantiate() as Drone
	player.add_child(drone)
	player.move_child(drone, 1) # add after shadow
	
	var game = player.owner as Game
	drone.shots_fired.connect(game._on_player_shots_fired)
	drone.died.connect(game._on_drone_died)

