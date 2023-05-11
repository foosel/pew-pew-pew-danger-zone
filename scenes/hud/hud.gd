extends CanvasLayer
class_name HUD


@onready var health_bar = $LeftBar/MarginContainer/HealthBar as TextureProgressBar
@onready var bullet_bar = $RightBar/MarginContainer/HBoxContainer/BulletBar as TextureProgressBar
@onready var life_bar = $LeftBar/MarginContainer/LifeBar as TextureProgressBar

@onready var fps_label = $RightBar/MarginContainer/VBoxContainer/FPSLabel as Label
@onready var shield_label = $RightBar/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/ShieldLabel as Label
@onready var drone_label = $RightBar/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/DroneLabel as Label
@onready var bomb_label = $RightBar/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/BombLabel as Label

@onready var score_label = $MarginContainer/ScoreLabel as Label


var active_color = Color("#ffffff")
var inactive_color = Color("#3d3d3d")


func _ready() -> void:
	var left_bar = $LeftBar as ColorRect
	var right_bar = $RightBar as ColorRect
	
	var bar_size = Globals.visible_viewport.position.x
	left_bar.custom_minimum_size = Vector2(bar_size, 0)
	right_bar.custom_minimum_size = Vector2(bar_size, 0)
	
	Globals.shield_status.connect(_on_shield_status)
	Globals.drone_status.connect(_on_drone_status)
	Globals.bomb_status.connect(_on_bomb_status)
	
	reset_status_indicators()


func _process(_delta):
	var fps = Engine.get_frames_per_second()
	fps_label.text = str(fps) + " FPS"


func set_health(health: int) -> void:
	health_bar.value = health
	bullet_bar.value = 6 - health
	
	
func set_lives(lives: int) -> void:
	life_bar.value = lives


func set_score(score: int) -> void:
	score_label.text = "Score: " + str(score)


func disable_bars() -> void:
	health_bar.value = 0
	bullet_bar.value = 0


func reset_status_indicators() -> void:
	_on_shield_status(false)
	_on_drone_status(false)
	_on_bomb_status(false)


func _on_shield_status(state: bool) -> void:
	print("Shield status: " + str(state))
	shield_label.modulate = active_color if state else inactive_color


func _on_drone_status(state: bool) -> void:
	print("Drone status: " + str(state))
	drone_label.modulate = active_color if state else inactive_color


func _on_bomb_status(state: bool) -> void:
	print("Bomb status: " + str(state))
	bomb_label.modulate = active_color if state else inactive_color
