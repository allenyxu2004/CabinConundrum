extends CanvasLayer

const CHAR_READ_RATE = 0.5

var tween = Tween.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hide_textbox()



func hide_textbox():
	$TextboxContainer/MarginContainer/HBoxContainer/Label.text = ""
	$TextboxContainer.hide()

func show_textbox():
	$TextboxContainer.show()

func add_text(next_text):
	$TextboxContainer/MarginContainer/HBoxContainer/Label.text = next_text
	show_textbox()
	$TextboxContainer/MarginContainer/HBoxContainer/AnimationPlayer.play("show")


	
