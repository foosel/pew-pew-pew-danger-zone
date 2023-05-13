extends Node2D
class_name Level


@export var scroll_speed = 50

@onready var background = $Background as Sprite2D
@onready var exit = $Background/Exit as Area2D
@onready var exit_shape = $Background/Exit/CollisionShape2D as CollisionShape2D
@onready var bgm = $BGM as AudioStreamPlayer
@onready var bgm_animation = $BGM/AnimationPlayer as AnimationPlayer


signal player_reached_exit()


func _ready():
	var background_size = get_level_size()
	var viewport_size = get_viewport_rect().size
	background.position = Vector2(viewport_size.x / 2, -background_size.y / 2 + viewport_size.y)
	
	var rect = RectangleShape2D.new()
	rect.size = viewport_size
	exit_shape.shape = rect
	exit_shape.position = Vector2.ZERO

	exit.position = Vector2(0, -background_size.y / 2 + viewport_size.y / 2)

	print("Initialized level exit at " + str(exit.position))


func get_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy] = []
	for node in get_tree().get_nodes_in_group("Enemy"):
		if not node is Enemy:
			continue
		var enemy = node as Enemy
		if not enemy.is_alive():
			continue
		enemies.append(enemy)
	return enemies


func get_level_size() -> Vector2:
	return background.get_rect().size


func fade_out_bgm() -> void:
	bgm_animation.play("fade_out")


func _on_exit_body_entered(body):
	if body is Player:
		player_reached_exit.emit()
