extends Node2D


var visible_viewport = Rect2()

var scroll_speed = 50.0


signal shield_status(state: bool)
signal drone_status(state: bool)
signal bomb_status(state: bool)


var running_in_browser = OS.get_name() == "Web"
var high_score = 0

var save_game_version = 1
var save_game_path = "user://save_game.dat"

var current_scene = null

var stage_clear_showing = false
var game_over_showing = false


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	get_tree().get_root().connect("size_changed", _calculate_visible_viewport)
	_calculate_visible_viewport()
	
	load_save_game()
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("screenshot") and not running_in_browser:
		var path = "screenshot-" + str(Time.get_datetime_string_from_system()) + ".png"
		var image = get_viewport().get_texture().get_image()
		image.save_png(path)
		print("Saved screenshot as " + path)


func _calculate_visible_viewport() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var bar_size = (viewport_size.x - viewport_size.y) / 2

	visible_viewport.position.x = bar_size
	visible_viewport.size.x = viewport_size.y
	visible_viewport.size.y = viewport_size.y


func in_visible_viewport(pos: Vector2) -> bool:
	return visible_viewport.has_point(pos)
	

func in_visible_viewport_y(pos: Vector2) -> bool:
	var min_y = visible_viewport.position.y
	var max_y = min_y + visible_viewport.size.y
	return pos.y >= min_y and pos.y <= max_y


func player_controls_enabled() -> bool:
	return not game_over_showing and not stage_clear_showing


func load_save_game() -> void:
	if not FileAccess.file_exists(save_game_path):
		print("No save game yet")
		return

	var file = FileAccess.open(save_game_path, FileAccess.READ)
	var version = file.get_8()
	if version > save_game_version:
		print("Save game is from a newer version, can't load that")
		return
	high_score = file.get_32()
	print("Loaded save game file")


func write_save_game() -> void:
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_8(save_game_version)
	file.store_32(high_score)
	print("Written save game file")


func start_game() -> void:
	goto_scene("res://scenes/game/game.tscn")


func main_menu() -> void:
	goto_scene("res://scenes/menu/menu.tscn")


func goto_scene(path: String) -> void:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path: String) -> void:
	current_scene.free()
	
	var scene = load(path)
	current_scene = scene.instantiate()
	
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
