extends Node2D
class_name DroneAreaSprite

@export var radius = 200
@export var line_color: Color = Color("#db3ffd")
@export var fill_color: Color = Color("#f389f5")

func _draw():
	draw_circle_arc_poly(position, radius, 0, 360, fill_color, line_color)


func _process(_delta) -> void:
	queue_redraw()


func draw_circle_arc(c: Vector2, r: float, angle_from: float, angle_to: float, color: Color):
	var nb_points = 64
	var points = PackedVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points.push_back(c + Vector2(cos(angle_point), sin(angle_point)) * r)
	
	for index_point in range(nb_points):
		draw_line(points[index_point], points[index_point + 1], color, 2, true)


func draw_circle_arc_poly(c: Vector2, r: float, angle_from: float, angle_to: float, fc: Color, lc: Color):
	var nb_points = 64
	var points = PackedVector2Array()
	points.push_back(c)
	var colors = PackedColorArray([fc])
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points.push_back(c + Vector2(cos(angle_point), sin(angle_point)) * r)
	
	draw_polygon(points, colors)
	
	if lc:
		draw_circle_arc(c, r, angle_from, angle_to, lc)
		var angle_diff = clamp(abs(angle_from - angle_to), 0, 360)
		if angle_diff > 0 and angle_diff < 360:
			var point_from = c + Vector2(cos(angle_from), sin(angle_from)) * r
			var point_to = c + Vector2(cos(angle_to), sin(angle_to)) * r
			draw_line(c, point_from, lc, 2, true)
			draw_line(c, point_to, lc, 2, true)
