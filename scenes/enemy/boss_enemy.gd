extends Enemy


@export var satellite_rotate_speed = 3
@export var satellite_radius = 128


@onready var shield = $Shield as Area2D
@onready var shield_timer = $ShieldTimer as Timer


var satellites: Array[Enemy] = []
var angles: Array[float] = []


func _ready() -> void:
	for node in get_children():
		if node.is_in_group("Satellite"):
			if not node is Enemy:
				continue
			satellites.append(node as Enemy)
	
	if satellites:
		var angle_step = 2 * PI / satellites.size()
		var angle = 0
		for satellite in satellites:
			angles.append(angle)
			angle += angle_step
			
			satellite.died.connect(_on_satellite_died)


func _process(delta) -> void:
	for i in range(satellites.size()):
		angles[i] = wrap(angles[i] + delta * satellite_rotate_speed, 0, 2 * PI)
		if satellites[i] and is_instance_valid(satellites[i]):
			satellites[i].position = Vector2(sin(angles[i]), cos(angles[i])) * satellite_radius


func _on_satellite_died(enemy: Enemy) -> void:
	print("Satellite " + str(enemy) + " destroyed")
	if alive_satellites():
		# temporarily disable shield
		shield.hide()
		shield.monitoring = false
		shield_timer.start()
	else:
		# remove shield
		call_deferred("remove_child", shield)


func alive_satellites() -> Array[Enemy]:
	return satellites.filter(func(satellite): return satellite and is_instance_valid(satellite))
	

func hit(amount: int) -> void:
	if is_instance_valid(shield) and shield.monitoring:
		return
	super.hit(amount)


func _on_shield_body_entered(body):
	if body is Bullet:
		(body as Bullet).explode()


func _on_shield_timer_timeout():
	if alive_satellites().size() == 0:
		return
	shield.monitoring = true
	shield.show()
