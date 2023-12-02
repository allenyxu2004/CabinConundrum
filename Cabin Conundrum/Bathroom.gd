extends Node2D

var hand_cursor = preload("res://art/Utils/cursorHand.png")
var pillsFound = false
var screwDriverFound = false
var screwsFound = false
var checkedMirror = false
var screws = 0
var handleInteraction = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position.x = 2000
	$Camera2D.position.y = 0
	$CanvasLayer.visible = false
	$MirrorCrack.visible = false
	$BackArrow.visible = false
#	toggle_visiblity_off()
#	$VideoStreamPlayer.play()
#	await get_tree().create_timer(9.0).timeout
#	$TextBox.add_text("What the heck just happened? Where am I? I have to get out.")
#	await get_tree().create_timer(4.0).timeout
#	$TextBox.hide_textbox()
	$VideoStreamPlayer.visible = false
	$Mirror.visible = true
	$OpenMirror.visible = false
	$TextBox.visible = true
	$Pills.visible = false
	$Screwdriver.visible = false
	$BloodyBathtub.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_cursor_hand():
	Input.set_custom_mouse_cursor(hand_cursor)

func change_cursor_back():
	Input.set_custom_mouse_cursor(null)

func toggle_visiblity_off():
	$OpenMirror.visible = false
	$Mirror.visible = false
	$Sink.visible = false
	$Pills.visible = false
	$Screwdriver.visible = false

func toggle_visiblity_on():
	$OpenMirror.visible = true
	$Mirror.visible = true
	$Sink.visible = true
	$Pills.visible = true
	$Screwdriver.visible = true

func _on_area_open_mirror_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if checkedMirror == false:
			$TextBox.add_text("Who broke this mirror?")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$Mirror.visible = false
			$MirrorCrack.visible = true
			$MirrorCrack.play()
			await get_tree().create_timer(5.5).timeout
			$TextBox.add_text("Oh... it was me.")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$MirrorCrack.visible = false
			$Mirror.visible = true
			checkedMirror = true
		else:
			$OpenMirror.visible = true
			$Mirror.visible = false
			$Sink.visible = false
			$Pills.visible = true
			$Screwdriver.visible = true
			get_node("Mirror/Area2D/ClosedMirrorShape2D").disabled = true
			get_node("OpenMirror/Area2D/OpenMirrorShape2D").disabled = false
			get_node("Pills/Area2D/CollisionPolygon2D").disabled = false
			$TextBox.add_text("Lets see whats in the cabinet.")
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
		$TextBox.add_text("Oh no! I forgot to take my pills last night.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()


func _on_area_screw_driver_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		screwDriverFound = true
		if handleInteraction:
			if screwsFound:
				$TextBox.add_text("I can use this to fix the handle now.")
			else:
				$TextBox.add_text("I can use this to fix the handle. I just need some screws.")
		else:
			$TextBox.add_text("An ordinary screwdriver.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()		

func _on_area_crack_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$TextBox.add_text("How did this crack get here? I'll take a closer look.")
		await get_tree().create_timer(2.0).timeout
		$TextBox.hide_textbox()
		toggle_visiblity_off()
		$BloodyBathtub.visible = true
		$BackArrow.visible = true

func _on_area_broom_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$TextBox.add_text("Hmm. This could be useful later.")
		await get_tree().create_timer(3.0).timeout
		$TextBox.hide_textbox()

func _on_area_door_handle_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if handleInteraction == false:
			$TextBox.add_text("How did this happen? I can't open the door without fixing this handle with screws.")
			handleInteraction = true
			await get_tree().create_timer(3.0).timeout
			$TextBox.hide_textbox()
		if screwsFound and screwDriverFound:
			$TextBox.add_text("Great! Now I can go to the next room. There should be more clues there.")
			await get_tree().create_timer(2.5).timeout
			$TextBox.hide_textbox()
			$CanvasLayer/AnimationPlayer.play("new_animation")
			$Camera2D.position.x = 2000
			$Camera2D.position.y = 0
			
			$CanvasLayer2/AnimationPlayer.play("new_animation2")
			

func _on_area_blood_tub_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$BathtubBloodyHands.visible = true
		await get_tree().create_timer(1.0).timeout
		$TextBox.add_text("That blood is definitely from my injuries.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()
		$BathtubBloodyHands.visible = false

func _on_area_toilet_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if handleInteraction:
			if screwDriverFound:
				$TextBox.add_text("I can use the screws here to fix the door!")
				await get_tree().create_timer(2.0).timeout
				$TextBox.hide_textbox()
				$CanvasLayer.visible = true
				$CanvasLayer2.visible = true
				$CanvasLayer/AnimationPlayer.play("new_animation")
				$TextBox.add_text("* You unscrew the screws on the toilet.")
				await get_tree().create_timer(3.0).timeout
				$CanvasLayer2/AnimationPlayer.play("new_animation2")
				$TextBox.hide_textbox()
				$CanvasLayer.visible = false
				$CanvasLayer2.visible = false
				screwsFound = true

			else:
				$TextBox.add_text("I can use the screws here to fix the door. I just need a way to remove them")
				await get_tree().create_timer(3.0).timeout
				$TextBox.hide_textbox()
		else:
				$TextBox.add_text("It's a normal toilet.")
				await get_tree().create_timer(1.5).timeout
				$TextBox.hide_textbox()

func _on_area_back_arrow(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$BloodyBathtub.visible = false
		$BathtubBloodyHands.visible = false
		$BackArrow.visible = false

# ========================================================================
# ========================================================================

# BEDROOM SECTION

# ========================================================================
# ========================================================================
var remote = false
var dvdInteracted = false

func display_text(text, delay):
	$TextBox.add_text(text)
	await get_tree().create_timer(delay).timeout
	$TextBox.hide_textbox()


func to_bathroom(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Camera2D.position.x = -90
		$Camera2D.position.y = -70

func to_livingroom(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Camera2D.position.x = 4000
		$Camera2D.position.y = 0

func drawers_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("There just seems to be clothes here.", 1.0)

func drawers_special_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("Some pills! I can finally think straight now.", 2.0)
		display_text("* Memories Unlocked! Press TAB to view. *", 2.0)

func tv_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if remote:
			display_text("Let's see what the TV was playing", 1.5)
			$MovieClip.visible = true
			$MovieClip.play()
			await get_tree().create_timer(18.0).timeout
			$MovieClip.visible = false
			if dvdInteracted == false:
				display_text("Hmm, that film seemed familiar.", 1.5)
		else:
			display_text("I might be able to see something if I find a remote.", 2.0)

func remote_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("This remote seems to connect to the TV", 2.0)
		remote = true
	

		

