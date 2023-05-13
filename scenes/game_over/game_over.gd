extends CanvasLayer
class_name GameOver


@onready var text = $CenterContainer/VBoxContainer/GameOverText as Label
@onready var final_score = $CenterContainer/VBoxContainer/FinalScore as Label
@onready var new_highscore = $CenterContainer/VBoxContainer/NewHighscore as Label
@onready var stats = $CenterContainer/VBoxContainer/Stats as Label
@onready var animation = $AnimationPlayer as AnimationPlayer


func display(score: int, highscore: bool, won: bool, shots_fired: int, enemies_killed: int) -> void:
	Globals.game_over_showing = true
	if won:
		text.text = "You have finished the game!"
	else:
		text.text = "Game Over!"

	final_score.text = "Final score: " + str(score)

	if highscore:
		new_highscore.show()
	else:
		new_highscore.hide()
	
	stats.text = "Shots fired: " + str(shots_fired) + "\nEnemies killed: " + str(enemies_killed)

	animation.play("fade_in")

