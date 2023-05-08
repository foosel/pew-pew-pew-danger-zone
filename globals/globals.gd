extends Node2D


var visible_viewport = Rect2()

var scroll_speed = 50.0


func _ready() -> void:
	get_tree().get_root().connect("size_changed", _calculate_visible_viewport)
	_calculate_visible_viewport()


func _calculate_visible_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var bar_size = (viewport_size.x - viewport_size.y) / 2

	visible_viewport.position.x = bar_size
	visible_viewport.size.x = viewport_size.y
	visible_viewport.size.y = viewport_size.y
