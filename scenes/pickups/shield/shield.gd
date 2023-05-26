extends Area2D
class_name Shield

const FULL_HEALTH = 10

@onready var health = FULL_HEALTH
@onready var shield_sfx = $ShieldSFX as AudioStreamPlayer

## TODO: deflect bullets instead of "eating" them?


func reset_health() -> void:
	health = FULL_HEALTH
	Globals.shield_status.emit(true, health)


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
		else:
			Globals.shield_status.emit(true, health)


func _on_player_died() -> void:
	_deactivate()


func _activate() -> void:
	Globals.shield_status.emit(true, health)


func _deactivate() -> void:
	Globals.shield_status.emit(false, health)
	queue_free()
