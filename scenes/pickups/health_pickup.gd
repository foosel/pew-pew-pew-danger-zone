extends Pickup


@export var healing_amount = 1
@export var replacement_points = 5


func pickup(player: Player) -> void:
	super.pickup(player)
	if not player.add_health(healing_amount):
		# player already at full health, ok, add some points then
		player.add_points(replacement_points)
