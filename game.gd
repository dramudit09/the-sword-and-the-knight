extends Node

@onready var main_menu: MainMenu = %MainMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu

func _on_main_menu_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true
	pass # Replace with function body.
