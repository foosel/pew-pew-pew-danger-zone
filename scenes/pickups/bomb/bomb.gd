extends Node2D
class_name Bomb

@export var explosion_radius = 200
@export var explosion_damage = 50


signal exploded()


@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var sfx = $ExplosionSFX as AudioStreamPlayer


func _input(event):
	if event.is_action_pressed("action"):
		explode()


func explode() -> void:
	animation_player.play("explode")
	sfx.play()
	exploded.emit()

	var nodes = get_tree().get_nodes_in_group("Enemy") + get_tree().get_nodes_in_group("Bullet")
	for node in nodes:
		var distance = (node.global_position - global_position).length()
		if distance < explosion_radius:
			if node is Enemy:
				(node as Enemy).hit(explosion_damage)
			elif node is Bullet:
				(node as Bullet).explode()

	await animation_player.animation_finished
	await sfx.finished
	queue_free()


func _on_player_died():
	queue_free()


