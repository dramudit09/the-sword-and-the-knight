class_name MainMenu extends MarginContainer

signal settings_pressed

func _on_new_game_button_pressed() -> void:
	print("New Game Pressed")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	print("Settings Pressed")
	settings_pressed.emit()
	pass # Replace with function body.
