class_name MainMenu extends MarginContainer

@onready var new_game_button_cursor : ColorRect = %NewGameButtonCursor
@onready var new_game_button : Button = %NewGameButton
@onready var settings_button_cursor : ColorRect = %SettingsButtonCursor
@onready var settings_button : Button = %SettingsButton
@onready var quit_button_cursor : ColorRect = %QuitButtonCursor
@onready var quit_button : Button = %QuitButton
@onready var flame_cursor : GPUParticles2D = %FlameCursor
@onready var cursor_positions = [new_game_button_cursor, settings_button_cursor, quit_button_cursor]
@onready var buttons = [new_game_button, settings_button, quit_button]

signal settings_pressed
signal new_game_pressed

var first_process = true
var current_cursor_index = -1

func move_cursor(forward = true) -> void:
	current_cursor_index += 1 if forward else -1
	# Wrap back to the first cursor position if we've gone past the end
	if current_cursor_index >= len(cursor_positions):
		current_cursor_index = 0
	elif current_cursor_index < 0:
		current_cursor_index = len(cursor_positions) - 1
	var game_button_position = cursor_positions[current_cursor_index].global_position
	# Adjust it to match roughly the center of the cursor
	game_button_position.x += 32
	game_button_position.y += 8
	print(game_button_position)
	flame_cursor.global_position = game_button_position 
	
func _on_new_game_button_pressed() -> void:
	print("New Game Pressed")
	new_game_pressed.emit()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	print("Settings Pressed")
	settings_pressed.emit()

func _ready() -> void:
	set_process_unhandled_key_input(true)
	
func _process(float) -> void:
	if first_process:
		move_cursor()
		first_process = false

func activate(process_active:bool = false)->void: 
	set_process_unhandled_key_input(true)

func deactivate()->void: 
	set_process_unhandled_key_input(false)

func _unhandled_key_input(event: InputEvent) -> void:  
	if event.is_action_pressed("ui_accept"):
		buttons[current_cursor_index].pressed.emit()
		print(buttons[current_cursor_index].get_global_rect())
	elif event.is_action_pressed("ui_down"):
		move_cursor()
		pass
	elif event.is_action_pressed("ui_up"): 
		move_cursor(false)
		pass
	elif event.is_action_pressed("ui_left"): 
#		keypress.emit("ui_left")
		pass
	elif event.is_action_pressed("ui_right"): 
#		keypress.emit("ui_right")
		pass
	elif event.is_action_pressed("ui_select"): 
#		space.emit()
		pass
	elif event.is_action_pressed("ui_cancel"): 
#		esc.emit()
		pass
