class_name VisualNovel extends Node

@onready var dialogue_label : RichTextLabel = %DialogueLabel

var dialogue_lines = ["Hi", "How's it going?", "OK bye"]
var dialogue_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_label.text = dialogue_lines[dialogue_index]
	if get_tree().current_scene == self:
		set_process_unhandled_key_input(true)
	else:
		set_process_unhandled_key_input(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func activate(process_active:bool = false) -> void: 
	set_process_unhandled_key_input(true)

func deactivate()->void: 
	set_process_unhandled_key_input(false)

func _unhandled_key_input(event: InputEvent) -> void:  
	if event.is_action_pressed("ui_accept"):
		dialogue_index += 1
		dialogue_label.text = dialogue_lines[dialogue_index]
