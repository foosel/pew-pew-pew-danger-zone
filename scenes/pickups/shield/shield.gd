extends Area2D
class_name Shield

@export var full_health = 10

@onready var health = full_health
@onready var shield_sfx = $ShieldSFX as AudioStreamPlayer

## TODO: deflect bullets instead of "eating" them?


func reset_health() -> void:
	health = full_health


func _ready() -> void:
	shield_sfx.play()
	_activate()


func _on_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
		health -= 1
		if health <= 0:
				shield_sfx.play()
				await shield_sfx.finished
				_deactivate()


func _on_player_died() -> void:
	_deactivate()


func _activate() -> void:
	Globals.shield_status.emit(true)


func _deactivate() -> void:
	Globals.shield_status.emit(false)
	queue_free()
