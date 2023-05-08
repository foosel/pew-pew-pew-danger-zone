extends Behaviour
class_name PlayerTargetingBehaviour


var player: Player


func _ready() -> void:
	super()
	var player_node = get_tree().get_first_node_in_group("Player")
	assert(player_node is Player)
	assert(player_node)
	player = player_node
