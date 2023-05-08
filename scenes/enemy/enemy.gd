extends CharacterBody2D
class_name Enemy

@export var health = 3
@export var speed = 500
@export var score = 250


signal shots_fired(scene: PackedScene, shots: Array, homing: bool)
signal died(enemy: Enemy)


var behaviours = []


func _ready() -> void:
	for child in get_children():
		if child is Behaviour:
			behaviours.append(child as Behaviour)
	velocity = Vector2.UP * Globals.scroll_speed


func shoot(scene: PackedScene, shots: Array, homing: bool) -> void:
	shots_fired.emit(scene, shots, homing)


func hit() -> void:
	health -= 1

	if health <= 0:
		died.emit(self)
		queue_free()


func _physics_process(delta):
	for behaviour in behaviours:
		behaviour._physics_process_behaviour(delta)


func _on_hurtbox_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
		hit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	#pass
