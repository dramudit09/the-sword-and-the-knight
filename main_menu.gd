class_name MainMenu extends MarginContainer

signal settings_pressed
signal new_game_pressed

func _on_new_game_button_pressed() -> void:
	print("New Game Pressed")
	new_game_pressed.emit()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	print("Settings Pressed")
	settings_pressed.emit()
