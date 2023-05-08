extends Node
class_name Behaviour


var enemy: Enemy


func _ready() -> void:
	var parent = get_parent()
	await parent.ready
	assert(parent is Enemy)
	enemy = parent


func _physics_process_behaviour(_delta) -> void:
	pass

