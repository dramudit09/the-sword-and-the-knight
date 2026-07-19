class_name VisualNovel extends Node

@onready var typewriter_text_label : TypewriterTextLabel = %TypewriterTextLabel
@onready var answer_one_button : Button = %AnswerOneButton
@onready var answer_two_button : Button = %AnswerTwoButton
@onready var character_panel : PanelContainer = %CharacterPanel
@onready var character_label: RichTextLabel = %CharacterLabel

var dialogue_lines = ["Hi", "How's it going?", "OK bye"]
var dialogue_index = 0
var characters = {}

class Dialogue:
	func _init(character_name: String, speech: String) -> void:
		var char_name = character_name
		var text = speech

class GameScript:
	var instructions : Dictionary = { "" : {
		"" : [] 
		}
	}
	var menus : Array = []
	var current_menu : String = ""
	var current_branch : String = ""
	var previous_menu : String = ""
	var previous_branch : String = ""
	var menu_stack : Array = ["",]
	var branch_stack : Array = ["",]
	var current_menu_data : Dictionary = {
		"previous_menu" : "",
		"branches" : ""
	}

	func _init() -> void:
		pass
		
	func add_instruction(instruction) -> void:
		self.instructions[self.current_menu][self.current_branch].push_back(instruction)
		
	func new_menu(menu_name) -> void:
		var new_instruction = { 
			"menu_name" : menu_name,
			"previous_menu" : self.current_menu,
			"previous_branch" : self.current_branch,
		}
		self.instructions[self.current_menu][self.current_branch].push_back(new_instruction)
		self.instructions[menu_name] = {}
		self.previous_menu = self.current_menu
		self.menu_stack.push_back(self.current_menu)
		self.previous_branch = self.current_branch
		self.branch_stack.push_back(self.current_branch)
		self.current_menu = menu_name
		self.current_branch = ""
	
	func end_menu() -> void:
		# Let the current branch know how to switch back to a previous menu/path
		self.instructions[self.current_menu][current_branch].push_back({
			"previous_menu" : self.previous_menu,
			"previous_branch" : self.previous_branch
		})		
		self.current_menu = menu_stack.pop_back()
		self.current_branch = branch_stack.pop_back()
	
	func new_branch(choice_text) -> void:
		# Let the current branch know how to switch back to a previous menu/path
		if(self.current_branch in self.instructions[self.current_menu]):
			self.instructions[self.current_menu][self.current_branch].push_back({
				"previous_menu" : self.previous_menu,
				"previous_branch" : self.previous_branch
			})
		self.current_branch = choice_text
		self.instructions[self.current_menu][choice_text] = []
		
var game_script = GameScript.new()

func process_script():
	var file = FileAccess.open("res://text/script.txt", FileAccess.READ)
	var content = file.get_as_text()
	var current_menu_label = "start"
	var current_instruction_list = []
	content = content.split("\n")
	for line in content:
		line = line.strip_edges(true, true)
		if not line or line[0] == "#":
			# comment, ignore
			continue
		var spline = line.split(" ")
		# Handle definition of characters
		if spline[0] == "define":
			# Line looks like: define s = Character("Sword")
			var quoted_words = spline[3].split('"')
			var reference_name = spline[1]
			var char_name = quoted_words[1]
			print("Found character definition: ", reference_name, "/", char_name)
			characters[reference_name] = char_name
			print("characters: ", characters)
		elif spline[0] == "menu":
			# Start of a new menu
			# Line looks like: menu "What do you fear?":
			var menu_prompt = line.substr(len("menu \""))
			# Remove the ":" at the end
			menu_prompt = menu_prompt.substr(0, len(menu_prompt) - 2)
#			var label_name_with_colon = spline.slice(1, len(spline))
#			var label_name = label_name_with_colon.substr(0, len(label_name_with_colon) - 2)
			print("Found a menu: ", menu_prompt)
			game_script.new_menu(menu_prompt)
		elif (len(spline) > 1 and spline[1][0] == '"'):
			# Dialogue line
			# Line looks like: s "Oh. I see. So you’ve given up, right?"
			var speaker = line[0]
			var text = line.substr(2)
			var dialogue = Dialogue.new(speaker, text)
			game_script.add_instruction(line)
		elif line and line[0] == '"':
			# Menu branch
			# Line looks like: "I answer thusly: boo":
			var branch_name = line.substr(0, len(line) -1)
			game_script.new_branch(line.substr(0, len(line) -1))
			print("Found a branch: ", branch_name)
		elif line == "menu_end":
			# Menu ending
			# Line looks like: menu_end
			game_script.end_menu()

func change_dialogue(new_line, character):
	typewriter_text_label.new_dialogue(new_line)
	if character:
		character_panel.visible = true
		character_label.text = character
	else:
		character_panel.visible = false
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_script()
	next_dialogue_line()
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

var running_game_menu = ""
var running_game_branch = ""
var waiting_for_choice = false

func start(speed) -> void:
	typewriter_text_label.speed = speed
	next_dialogue_line()

func next_dialogue_line() -> void:
	print("Waiting for choice: ", waiting_for_choice)
	if waiting_for_choice:
		# TODO: Handle cursor
		return
	
	dialogue_index += 1
	var dia = game_script.instructions[running_game_menu][running_game_branch].pop_front()
	while(dia is Dictionary and "menu_name" not in dia and "previous_menu" in dia):
		running_game_menu = dia["previous_menu"]
		running_game_branch = dia["previous_branch"]
		dia = game_script.instructions[running_game_menu][running_game_branch].pop_front()
	print(dia)
	var character = "Question:"
	if dia is Dictionary:
		print(dia)
		running_game_menu = dia["menu_name"]
		dia = running_game_menu + "\n"
		var choices = game_script.instructions[running_game_menu].keys()
		# TODO: Show more any number of choices, not just two (if ever needed)
		answer_one_button.text = choices[0]
		answer_two_button.text = choices[1]
		running_game_branch = choices[0]
		answer_one_button.visible = true
		answer_two_button.visible = true
		waiting_for_choice = true
	else:
		# Regular dialogue, something like: k "I know who you are!"
		if dia:
			var character_ref = dia[0]
			dia = dia.substr(2, len(dia)-2)
			character = characters[character_ref]
	change_dialogue(dia, character)

func _unhandled_key_input(event: InputEvent) -> void:  
	if event.is_action_pressed("ui_accept"):
		next_dialogue_line()

func _on_answer_one_button_pressed() -> void:
	running_game_branch = answer_one_button.text
	answer_one_button.visible = false
	answer_two_button.visible = false
	waiting_for_choice = false
	change_dialogue(running_game_branch, "")

func _on_answer_two_button_pressed() -> void:
	running_game_branch = answer_two_button.text
	answer_one_button.visible = false
	answer_two_button.visible = false
	waiting_for_choice = false
	change_dialogue(running_game_branch, "")
