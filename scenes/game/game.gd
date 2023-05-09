extends Node2D


@onready var player = $Player as Player
@onready var bullet_manager = $BulletManager as BulletManager
@onready var respawn_timer = $RespawnTimer as Timer
@onready var camera = $Camera as ShakeableCamera
@onready var focus_point = $FocusPoint as Node2D
@onready var hud = $HUD as HUD
@onready var explosion_scene = load("res://scenes/explosion/explosion.tscn") as PackedScene

var score = 0
var lives = 3


func _process(delta):
	focus_point.position += Vector2.UP * Globals.scroll_speed * delta
	Globals.visible_viewport.position.y = focus_point.position.y


func _on_player_shots_fired(scene, shots, homing):
	var target = null
	if homing:
		var closest = null
		var closest_distance = 0
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy = enemy as Enemy
			var distance = (player.position - enemy.position).length
			if closest == null or distance < closest_distance:
				closest = enemy
				closest_distance = distance
		target = closest

	bullet_manager.spawn_bullets(scene, shots, target)


func _on_enemy_shots_fired(scene, shots, homing):
	var target = null
	if homing:
		target = player
	bullet_manager.spawn_bullets(scene, shots, target)


func _on_enemy_died(enemy):
	var explosion = explosion_scene.instantiate()
	explosion.position = enemy.position
	add_child(explosion)
	explosion.start()
	camera.add_trauma(5)
	score += enemy.score
	hud.set_score(score)


func _on_player_hurt():
	camera.add_trauma(1)
	hud.set_health(player.health)


func _on_player_died():
	var explosion = explosion_scene.instantiate()
	explosion.position = player.position
	add_child(explosion)
	explosion.start()
	call_deferred("remove_child", player)
	respawn_timer.start()
	camera.add_trauma(5)
	lives -= 1
	hud.disable_bars()
	hud.set_lives(lives)


func _on_respawn_timer_timeout():
	var respawn_position = Vector2(
		Globals.visible_viewport.position.x + Globals.visible_viewport.size.x / 2, 
		Globals.visible_viewport.position.y + Globals.visible_viewport.size.y - 70
	)
	player.respawn(respawn_position)
	add_child(player)
	hud.set_health(player.health)
