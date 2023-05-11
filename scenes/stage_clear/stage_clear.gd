extends CanvasLayer
class_name StageClear


@onready var text = $CenterContainer/VBoxContainer/StageClearText as Label
@onready var current_score = $CenterContainer/VBoxContainer/CurrentScore as Label
@onready var animation = $AnimationPlayer as AnimationPlayer


func display(score: int, level: int) -> void:
	text.text = "Stage " + str(level) + " cleared!"
	current_score.text = "Current score: " + str(score)
	animation.play("fade_in")


func remove() -> void:
	animation.play_backwards("fade_in")
	await animation.animation_finished
