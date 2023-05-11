extends Node2D
class_name Level


@export var scroll_speed = 50

@onready var background = $Background as Sprite2D

signal player_reached_exit()


func _ready():
	var background_size = get_level_size()
	var viewport_size = get_viewport_rect().size
	background.position = Vector2(viewport_size.x / 2, -background_size.y / 2 + viewport_size.y)


func get_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy] = []
	for node in get_children():
		if node is Enemy:
			enemies.append(node as Enemy)
	return enemies


func get_level_size() -> Vector2:
	return background.get_rect().size


func _on_exit_body_entered(body):
	if body is Player:
		player_reached_exit.emit()
