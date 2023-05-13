extends Node2D
class_name Bomb

@export var explosion_radius = 200
@export var explosion_damage = 50


signal exploded(bomb: Bomb)


@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var sfx = $ExplosionSFX as AudioStreamPlayer


func _ready() -> void:
	_activate()


func _input(event):
	if Globals.player_controls_enabled() and event.is_action_pressed("action"):
		explode()


func explode() -> void:
	animation_player.play("explode")
	sfx.play()
	exploded.emit(self)

	var nodes = get_tree().get_nodes_in_group("Enemy") + get_tree().get_nodes_in_group("Bullet") + get_tree().get_nodes_in_group("Pickup")
	for node in nodes:
		var distance = (node.global_position - global_position).length()
		if distance < explosion_radius:
			if node is Enemy:
				(node as Enemy).hit(explosion_damage)
			elif node is Bullet:
				(node as Bullet).explode()
			elif node is Pickup:
				node.queue_free()

	await animation_player.animation_finished
	await sfx.finished
	_deactivate()


func _on_player_died():
	_deactivate()


func _activate() -> void:
	Globals.bomb_status.emit(true)


func _deactivate() -> void:
	Globals.bomb_status.emit(false)
	queue_free()
