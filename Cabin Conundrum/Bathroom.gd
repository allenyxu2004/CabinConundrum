extends Node2D

var hand_cursor = preload("res://art/Utils/cursorHand.png")
var pillsFound = false
var screwDriverFound = false
var screwsFound = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$OpenMirror.visible = false

	
	$Pills.visible = false
	
	$Screwdriver.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_cursor_hand():
	Input.set_custom_mouse_cursor(hand_cursor)

func change_cursor_back():
	Input.set_custom_mouse_cursor(null)

func _on_area_open_mirror_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$OpenMirror.visible = true
		$Mirror.visible = false
		$Sink.visible = false
		$Pills.visible = true
		$Screwdriver.visible = true
		get_node("Mirror/Area2D/ClosedMirrorShape2D").disabled = true
		get_node("OpenMirror/Area2D/OpenMirrorShape2D").disabled = false
		get_node("Pills/Area2D/CollisionPolygon2D").disabled = false
		$TextBox.add_text("Lets see whats in the cabinet")
		await get_tree().create_timer(2.0).timeout
		$TextBox.hide_textbox()

func _on_area_close_mirror_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$OpenMirror.visible = false
		$Mirror.visible = true
		$Sink.visible = true
		$Pills.visible = false
		$Screwdriver.visible = false
		get_node("Mirror/Area2D/ClosedMirrorShape2D").disabled = false
		get_node("OpenMirror/Area2D/OpenMirrorShape2D").disabled = true
		get_node("Pills/Area2D/CollisionPolygon2D").disabled = true
		$TextBox.hide_textbox()
		

func _on_area_pills_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		pillsFound = true
		$TextBox.add_text("Oh no. I forgot to take my pills didn't I")
		await get_tree().create_timer(4.0).timeout
		$TextBox.hide_textbox()


func _on_area_screw_driver_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		screwDriverFound = true
		if screwsFound:
			$TextBox.add_text("I can use this to fix the handle now")
		else:
			$TextBox.add_text("I can use this to fix the handle. I just need some screws")
		await get_tree().create_timer(3.0).timeout
		$TextBox.hide_textbox()		

