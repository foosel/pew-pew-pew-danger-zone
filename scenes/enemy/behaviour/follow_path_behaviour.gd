extends Behaviour
class_name FollowPathBehaviour


var path: Path2D
var path_points: PackedVector2Array
var path_index = 0


func _ready() -> void:
	super()
	for child in get_children():
		if child is Path2D:
			path = child as Path2D
	path_points = path.curve.get_baked_points()


func _physics_process_behaviour(_delta) -> void:
	var target = path_points[path_index]
	var position = enemy.position
	if position.distance_to(target) < 1:
		path_index = wrapi(path_index + 1, 0, path_points.size())
		target = path_points[path_index]
	
	var difference = target - position
	var distance = difference.length()
	var direction = difference.normalized()
	enemy.velocity = direction * min(distance, enemy.speed)
	enemy.move_and_slide()
	
