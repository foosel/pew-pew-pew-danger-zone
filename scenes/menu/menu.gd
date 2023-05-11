extends Control



@onready var main = $Main as Control
@onready var new_game = $"Main/HBoxContainer/New Game" as Button
@onready var exit = $Main/HBoxContainer/Exit as Button
@onready var highscore = $Main/Highscore as Label

@onready var credits = $Credits as Control
@onready var back = $Credits/MarginContainer/Back as Button

func _ready() -> void:
	if Globals.running_in_browser:
		exit.hide()
	show_main()


func _on_new_game_pressed():
	Globals.start_game()


func _on_credits_pressed():
	show_credits()


func _on_back_pressed():
	show_main()


func _on_exit_pressed():
	get_tree().quit()


func show_main() -> void:
	main.show()
	credits.hide()
	new_game.grab_focus()
	highscore.text = "Highscore: " + str(Globals.high_score)
	

func show_credits() -> void:
	main.hide()
	credits.show()
	back.grab_focus()


