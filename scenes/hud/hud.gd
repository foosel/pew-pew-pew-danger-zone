extends CanvasLayer
class_name HUD


@onready var health_bar = $LeftBar/MarginContainer/HealthBar as TextureProgressBar
@onready var bullet_bar = $RightBar/MarginContainer/BulletBar as TextureProgressBar
@onready var score_label = $MarginContainer/ScoreLabel as Label
@onready var life_count = $LeftBar/MarginContainer/HBoxContainer/LifeCount as Label
@onready var fps_label = $RightBar/MarginContainer/FPSLabel


func _ready() -> void:
	var left_bar = $LeftBar as ColorRect
	var right_bar = $RightBar as ColorRect
	
	var bar_size = Globals.visible_viewport.position.x
	left_bar.custom_minimum_size = Vector2(bar_size, 0)
	right_bar.custom_minimum_size = Vector2(bar_size, 0)


func _process(_delta):
	var fps = Engine.get_frames_per_second()
	fps_label.text = str(fps) + " FPS"


func set_health(health: int) -> void:
	health_bar.value = health
	bullet_bar.value = 4 - health
	
	
func set_lives(lives: int) -> void:
	life_count.text = "x " + str(lives)


func set_score(score: int) -> void:
	score_label.text = "Score: " + str(score)


func disable_bars() -> void:
	health_bar.value = 0
	bullet_bar.value = 0
