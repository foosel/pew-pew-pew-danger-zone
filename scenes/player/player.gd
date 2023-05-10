extends CharacterBody2D
class_name Player

const FULL_HEALTH = 5

@export var speed = 500.0
@export var bullet_fire_interval = .1
@export var bullet_speed = 750.0
@export var side_shot_angle: float = 10

signal shots_fired(shots: Array)
signal healed()
signal hurt()
signal died()
signal scored(amount: int)

var health: int = FULL_HEALTH
var last_shot: float = 0
var bullet_emitters: Array[PlayerBulletEmitter] = []

@onready var shot_sfx = $ShotSFX as AudioStreamPlayer
@onready var hurt_sfx = $HurtSFX as AudioStreamPlayer
@onready var pickup_sfx = $PickupSFX as AudioStreamPlayer
@onready var animation_player = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	for node in get_children():
		if node is PlayerBulletEmitter:
			bullet_emitters.append(node as PlayerBulletEmitter)


func _physics_process(_delta):
	if health <= 0:
		return
	
	if Input.is_action_pressed("shoot") and last_shot < Time.get_ticks_msec() - bullet_fire_interval * 1000:
		last_shot = Time.get_ticks_msec()
		shoot()

	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed + Vector2.UP * Globals.scroll_speed

	move_and_slide()

	var visible_viewport = Globals.visible_viewport
	position.x = clamp(
		position.x, 
		visible_viewport.position.x + 16, 
		visible_viewport.position.x + visible_viewport.size.x - 16
	)
	position.y = clamp(
		position.y,
		visible_viewport.position.y + 16,
		visible_viewport.position.y + visible_viewport.size.y - 16
	)


func shoot():
	var shots = []
	
	for emitter in bullet_emitters:
		if health in emitter.active_during:
			shots += emitter.shoot()
	
	shots_fired.emit(shots)
	shot_sfx.play()
	
#	var direction = Vector2.UP * bullet_speed
#
#	# spawn bullet in the middle
#	if health == 5 or health == 1:
#		shots.append({
#			"position": position + Vector2(0, -16), 
#			"velocity": direction
#		})
#
#	# spawn two bullets in the middle
#	if health <= 4: 
#		shots.append({
#			"position": position + Vector2(-10, -10), 
#			"velocity": direction
#		})
#		shots.append({
#			"position": position + Vector2(10, -10), 
#			"velocity": direction
#		})
#
#	# spawn two bullets on the wings
#	if health <= 3:
#		shots.append({
#			"position": position + Vector2(-12, 0), 
#			"velocity": direction.rotated(deg_to_rad(-side_shot_angle)),
#			"rotated": true
#		})
#		shots.append({
#			"position": position + Vector2(12, 0), 
#			"velocity": direction.rotated(deg_to_rad(side_shot_angle)),
#			"rotated": true
#		})
#
#	# spawn two more bullets on the wings
#	if health <= 2:
#		shots.append({
#			"position": position + Vector2(-12, 0), 
#			"velocity": direction.rotated(deg_to_rad(- 2 * side_shot_angle)),
#			"rotated": true
#		})
#		shots.append({
#			"position": position + Vector2(12, 0), 
#			"velocity": direction.rotated(deg_to_rad(2 * side_shot_angle)),
#			"rotated": true
#		})
#
#	shots_fired.emit(bullet_scene, shots, null)



func hit() -> void:
	if health <= 0:
		return

	health -= 1
	if health <= 0:
		died.emit()
	else:
		hurt.emit()
		hurt_sfx.play()
		animation_player.play("hurt")
		

func respawn(pos: Vector2) -> void:
	health = FULL_HEALTH
	position = pos
	animation_player.play("respawned")
	
	
func add_health(amount: int) -> void:
	health = clamp(health + amount, 0, FULL_HEALTH)
	healed.emit()
	

func add_points(amount: int) -> void:
	scored.emit(amount)


func _on_hurtbox_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
		hit()
	elif body is Enemy:
		hit()


func _on_pickuparea_body_entered(body):
	assert(body is Pickup)
	pickup_sfx.play()
	(body as Pickup).pickup(self)
	
