class_name SettingsMenu extends MarginContainer

@onready var text_speed_option_button : OptionButton = %TextSpeedOptionButton
@onready var volume_slider : HSlider = %VolumeHSlider

signal return_pressed

var text_speed : String
var volume : float

func _ready() -> void:
	text_speed = 	text_speed_option_button.get_item_text(text_speed_option_button.get_selected_id())
	print("Text speed: ", text_speed)
	volume = volume_slider.value
	print("Volume: ", volume)

func _on_full_screen_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_return_button_pressed() -> void:
	print("Settings screen 'Return' pressed.")
	return_pressed.emit()

func _on_text_speed_option_button_item_selected(index: int) -> void:
	text_speed = text_speed_option_button.get_item_text(index)
	print("Text speed is now: ", text_speed)


func _on_volume_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		volume = volume_slider.value
	print("Volume is now: ", volume)
