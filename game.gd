extends Node

@onready var main_menu: MainMenu = %MainMenu
@onready var settings_menu: SettingsMenu = %SettingsMenu
@onready var visual_novel: VisualNovel = %VisualNovel

func _ready() -> void:
	# TODO: Play the music at the current volume from the settings menu
	# Use settings_menu.volume
	pass

func _on_main_menu_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true

func _on_settings_menu_return_pressed() -> void:
	main_menu.visible = true
	settings_menu.visible = false


func _on_main_menu_new_game_pressed() -> void:
	main_menu.visible = false
	main_menu.deactivate()
	settings_menu.visible = false
	visual_novel.visible = true
	visual_novel.activate()
