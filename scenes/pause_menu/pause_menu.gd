extends PopupPanel


@onready var continue_button = $MarginContainer/VBoxContainer/Continue as Button


signal resume_game()
signal exit_game()


func _ready():
	continue_button.grab_focus()


func _on_continue_pressed():
	resume_game.emit()


func _on_exit_pressed():
	exit_game.emit()


func _on_popup_hide():
	resume_game.emit()


func _on_about_to_popup():
	continue_button.grab_focus()
