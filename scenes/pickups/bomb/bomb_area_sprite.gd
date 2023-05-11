extends Node2D
class_name BombAreaSprite

@export var radius = 200
@export var line_color: Color = Color("#272727")
@export var fill_color: Color = Color("#3d3d3d")

func _draw():
	draw_circle_arc_poly(position, radius, 0, 360, fill_color, line_color)


func _process(_delta) -> void:
	queue_redraw()


func draw_circle_arc(center: Vector2, radius: float, angle_from: float, angle_to: float, color: Color):
	var nb_points = 64
	var points = PackedVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	for index_point in range(nb_points):
		draw_line(points[index_point], points[index_point + 1], color, 2, true)


func draw_circle_arc_poly(center: Vector2, radius: float, angle_from: float, angle_to: float, fill_color: Color, line_color: Color):
	var nb_points = 64
	var points = PackedVector2Array()
	points.push_back(center)
	var colors = PackedColorArray([fill_color])
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	draw_polygon(points, colors)
	
	if line_color:
		draw_circle_arc(center, radius, angle_from, angle_to, line_color)
		var angle_diff = clamp(abs(angle_from - angle_to), 0, 360)
		if angle_diff > 0 and angle_diff < 360:
			var point_from = center + Vector2(cos(angle_from), sin(angle_from)) * radius
			var point_to = center + Vector2(cos(angle_to), sin(angle_to)) * radius
			draw_line(center, point_from, line_color, 2, true)
			draw_line(center, point_to, line_color, 2, true)
