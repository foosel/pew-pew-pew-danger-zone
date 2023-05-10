extends Area2D

@onready var timer = $Timer as Timer
@onready var shield_sfx = $ShieldSFX as AudioStreamPlayer

@export var duration = 5.0

## TODO: deflect bullets instead of "eating" them?


func _ready() -> void:
	shield_sfx.play()
	timer.wait_time = duration
	timer.start()


func _on_timer_timeout():
	shield_sfx.play()
	await shield_sfx.finished
	queue_free()


func _on_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()
