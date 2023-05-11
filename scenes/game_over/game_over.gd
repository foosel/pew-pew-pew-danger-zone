extends CanvasLayer
class_name GameOver


@onready var text = $CenterContainer/VBoxContainer/GameOverText as Label
@onready var final_score = $CenterContainer/VBoxContainer/FinalScore as Label
@onready var new_highscore = $CenterContainer/VBoxContainer/NewHighscore as Label
@onready var animation = $AnimationPlayer as AnimationPlayer


func display(score: int, highscore: bool, won: bool) -> void:
	if won:
		text.text = "You have finished the game!"
	else:
		text.text = "Game Over!"

	final_score.text = "Final score: " + str(score)

	if highscore:
		new_highscore.show()
	else:
		new_highscore.hide()

	animation.play("fade_in")
