extends Node2D


@export var duration: float = 0.2


func start() -> void:
	var smoke = $Smoke as CPUParticles2D
	var fire = $Fire as CPUParticles2D
	var timer = $Timer as Timer
	var sfx = $SFX as AudioStreamPlayer

	timer.wait_time = duration + 0.1
	
	fire.lifetime = duration
	smoke.lifetime = duration
	
	fire.emitting = true
	smoke.emitting = true
	#timer.start()

	sfx.play()
	await sfx.finished
	
	queue_free()


func _on_timer_timeout():
	queue_free()
