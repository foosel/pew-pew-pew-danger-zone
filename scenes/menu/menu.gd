extends Control


@onready var foreground = $Foreground as Control

@onready var main = $Main as Control
@onready var new_game = $"Main/HBoxContainer/New Game" as Button
@onready var exit = $Main/HBoxContainer/Exit as Button
@onready var highscore = $Main/Highscore as Label

@onready var how_to_play = $HowToPlay as Control
@onready var how_to_play_back = $HowToPlay/HBoxContainer/HowToPlayBack as Button

@onready var credits = $Credits as Control
@onready var credits_back = $Credits/MarginContainer/CreditsBack as Button


func _ready() -> void:
	if Globals.running_in_browser:
		exit.hide()
	show_main()


func _on_new_game_pressed():
	Globals.start_game()


func _on_how_to_play_pressed():
	show_how_to_play()


func _on_credits_pressed():
	show_credits()


func _on_back_pressed():
	show_main()


func _on_exit_pressed():
	get_tree().quit()


func show_main() -> void:
	foreground.show()
	main.show()
	how_to_play.hide()
	credits.hide()
	new_game.grab_focus()
	highscore.text = "Highscore: " + str(Globals.high_score)
	

func show_credits() -> void:
	foreground.show()
	main.hide()
	how_to_play.hide()
	credits.show()
	credits_back.grab_focus()


func show_how_to_play() -> void:
	foreground.hide()
	main.hide()
	how_to_play.show()
	credits.hide()
	how_to_play_back.grab_focus()

