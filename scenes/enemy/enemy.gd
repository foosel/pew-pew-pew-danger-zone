extends CharacterBody2D
class_name Enemy

@export var health = 10
@export var speed = 200
@export var score = 250

@export var min_score_pickups = 3
@export var max_score_pickups = 10

@export var activation_offset = -64

@onready var despawn_timer = $DespawnTimer as Timer
@onready var on_screen_notifier = $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D

var pickups = [
	null,
	load("res://scenes/pickups/health_pickup.tscn"),
	load("res://scenes/pickups/shield_pickup.tscn"),
	load("res://scenes/pickups/drone_pickup.tscn"),
	load("res://scenes/pickups/bomb_pickup.tscn")
]
var pickup_weights = [
	0.5, # nothing
	1.0, # health
	1.0, # shield
	1.0, # drone
	1.0 # bomb
]

var total_pickup_weight = 0.0
var weighted_pickups = []

signal shots_fired(shots: Array)
signal hurt(enemy: Enemy)
signal died(enemy: Enemy)
signal despawned(enemy: Enemy)


var behaviours = []
var active = false
var is_despawned = false


func _ready() -> void:
	for child in get_children():
		if child is Behaviour:
			behaviours.append(child as Behaviour)
	
	assert(pickups.size() == pickup_weights.size())
	for weight in pickup_weights:
		total_pickup_weight += weight
		weighted_pickups.append(total_pickup_weight)


func is_alive() -> bool:
	return health > 0 and not is_despawned


func shoot(shots: Array) -> void:
	var offset_position = position - Vector2(0, activation_offset)
	if not Globals.in_visible_viewport(offset_position):
		return
		
	for shot in shots:
		shot["base_velocity"] = velocity
	shots_fired.emit(shots)


func hit(damage: int) -> void:
	if health <= 0:
		return # make sure we no longer process this on an already dead enemy

	health -= damage

	if health <= 0:
		died.emit(self)
		queue_free()
	else:
		hurt.emit(self)


func get_pickup() -> PackedScene:
	var weight = randf_range(0, total_pickup_weight)
	for idx in range(weighted_pickups.size()):
		if weighted_pickups[idx] > weight:
			return pickups[idx]
	return null


func get_score_pickups(source: String) -> int:
	if source == "hurt":
		return 1
	return randi_range(min_score_pickups, max_score_pickups)


func _physics_process(delta):
	var offset_position = position - Vector2(0, activation_offset)
	if not Globals.in_visible_viewport_y(offset_position):
		return

	if not active:
		active = true
		print("Behaviour processing activated for enemy " + str(self))
	for behaviour in behaviours:
		behaviour._physics_process_behaviour(delta)


func _on_hurtbox_body_entered(body):
	if body is Bullet:
		var bullet = body as Bullet
		bullet.explode()
		call_deferred("hit", bullet.damage)
	elif body is Player:
		call_deferred("hit", 1)


func _on_visible_on_screen_notifier_2d_screen_entered():
	print("Enemy " + str(self) + " entered visible screen")
	if despawn_timer:
		despawn_timer.stop()


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Enemy " + str(self) + " exited visible screen")
	despawn_timer.start()


func _on_despawn_timer_timeout():
	is_despawned = true
	despawned.emit(self)
	queue_free()

