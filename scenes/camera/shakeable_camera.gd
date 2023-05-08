extends Camera2D
class_name ShakeableCamera

@export var trauma_power = 2 # Trauma exponent. Use [2, 3].
@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)
@export var max_roll = 0.1
@export var target: Node2D

var trauma = 0.0  # Current shake strength.
	
func _ready() -> void:
	randomize()
	
func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount, 1.0)

func _process(delta: float) -> void:
	if target:
		position = target.position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
func shake() -> void:
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)


