extends MarginContainer

@onready var color_rect : ColorRect = %ColorRect
@onready var typewriter_text_label : TypewriterTextLabel = %TypewriterTextLabel

signal intro_complete

enum Stages {
	PAUSE, 
	FADE, 
	SECOND_PAUSE, 
	TEXT_DISPLAY_START, 
	TEXT_DISPLAYING,
	WAITING_FOR_INPUT
}

var current_fade_color = 1.0
var current_stage : Stages = Stages.PAUSE
var pause_timer = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	typewriter_text_label.speed = "Slow"
	set_process_unhandled_key_input(true)	

func _process(delta: float) -> void:
	match current_stage:
		Stages.PAUSE:
			pause_timer -= delta
			if pause_timer <= 0.0:
				current_stage = Stages.FADE
			return
		Stages.FADE:
			current_fade_color -= delta * 0.20
			color_rect.color.r = current_fade_color
			color_rect.color.g = current_fade_color
			color_rect.color.b = current_fade_color + 0.1
			if current_fade_color <= 0.0:
				pause_timer = 1.0
				current_stage = Stages.SECOND_PAUSE
			return
		Stages.SECOND_PAUSE:
			pause_timer -= delta
			if pause_timer <= 0.0:
				current_stage = Stages.TEXT_DISPLAY_START
			return
		Stages.TEXT_DISPLAY_START:
			typewriter_text_label.visible = true
			current_stage = Stages.TEXT_DISPLAYING
			return
		Stages.TEXT_DISPLAYING:
			if typewriter_text_label.visible_characters >= len(typewriter_text_label.text):
				current_stage = Stages.WAITING_FOR_INPUT
			return
			

func skip_fade() -> void:
	print("got here 2")
	color_rect.color.r = 0.0
	color_rect.color.g = 0.0
	color_rect.color.b = 0.1
	current_stage = Stages.TEXT_DISPLAY_START			

func _unhandled_key_input(event: InputEvent) -> void:
	match current_stage:
		Stages.PAUSE:
			return skip_fade()
		Stages.FADE:
			return skip_fade()
		Stages.SECOND_PAUSE:
			return skip_fade()
		Stages.TEXT_DISPLAYING:
			if event.is_action_pressed("ui_accept"):			
				typewriter_text_label.visible_characters = len(typewriter_text_label.text)
			return
		Stages.WAITING_FOR_INPUT:
			if event.is_action_pressed("ui_accept"):
				set_process_unhandled_input(false)
				print("intro_complete emitted")
				intro_complete.emit()
			return
