extends Node

@onready var main_menu: MainMenu = %MainMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu

func _on_main_menu_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true

func _on_settings_menu_return_pressed() -> void:
	main_menu.visible = true
	settings_menu.visible = false
