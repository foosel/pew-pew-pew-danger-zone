extends Node2D

func show_up(parent_direction: Vector2) -> void:
	$LargeLine.points[1] = -parent_direction
	$MediumLine.points[1] = -parent_direction * 0.66
	$SmallLine.points[1] = -parent_direction * 0.33
