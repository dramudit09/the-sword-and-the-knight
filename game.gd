extends Node

var main_menu: MainMenu
var settings_menu: SettingsMenu
var visual_novel: VisualNovel
var intro_screen: IntroScreen

var text_speed = "Normal"

func _ready() -> void:
	var main_menu_res = load("res://main_menu.tscn")
	main_menu = main_menu_res.instantiate()
	main_menu.settings_pressed.connect(_on_main_menu_settings_pressed)
	main_menu.new_game_pressed.connect(_on_main_menu_new_game_pressed)
	main_menu.activate()
	self.add_child(main_menu)

func _on_main_menu_settings_pressed() -> void:
	var settings_scene_res = load("res://settings_menu.tscn")
	settings_menu = settings_scene_res.instantiate()
	settings_menu.return_pressed.connect(_on_settings_menu_return_pressed)
	main_menu.deactivate()
	self.remove_child(main_menu)
	self.add_child(settings_menu)

func _on_settings_menu_return_pressed() -> void:
	main_menu.activate()
	self.add_child(main_menu)
	self.remove_child(settings_menu)

func _on_main_menu_new_game_pressed() -> void:
	main_menu.deactivate()
	self.remove_child(main_menu)
	self.remove_child(settings_menu)
	var intro_screen_res = load("res://intro_screen.tscn")
	intro_screen = intro_screen_res.instantiate()
	intro_screen.intro_complete.connect(_on_intro_screen_intro_complete)
	self.add_child(intro_screen)

func _on_intro_screen_intro_complete() -> void:
	self.remove_child(intro_screen)
	var visual_novel_res = load("res://visual_novel.tscn")
	visual_novel = visual_novel_res.instantiate()
	self.add_child(visual_novel)
	visual_novel.activate()
	visual_novel.start(text_speed)
