class_name TypewriterTextLabel extends RichTextLabel

var time_since_text_changed : float = 0.0
var speed = "Normal"
var speed_option_to_multiplier : Dictionary = { 
	"Slow" : 20,
	"Normal" : 50,
	"Fast" : 90
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func new_dialogue(text) -> void:
	self.text = text
	self.visible_characters = 0
	time_since_text_changed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Don't update visible characters if we've displayed all the text already
	if self.visible_characters >= len(self.text):
		return
	time_since_text_changed += delta
	if time_since_text_changed:
		self.visible_characters = time_since_text_changed * speed_option_to_multiplier[speed]
		print(time_since_text_changed)
