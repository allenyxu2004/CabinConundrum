extends Node2D

var hand_cursor = preload("res://art/Utils/cursorHand.png")
var pillsFound = false
var screwDriverFound = false
var screwsFound = false
var checkedMirror = false
var screws = 0
var handleInteraction = false
var broom = false
var bedroom = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position.x = 2000
	$Camera2D.position.y = 0
	$CanvasLayer.visible = false
	$MirrorCrack.visible = false
	$BackArrow.visible = false
	toggle_visiblity_off()
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
	$bathroomAmbience.play()
	$bedroomLivingRoomAmbience.play()
	$bedroomLivingRoomAmbience.set_volume_db(-100.0)
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
		if bedroom == true:
			$TextBox.add_text("Let me use this to sweep the glass away.")
			await get_tree().create_timer(3.0).timeout
			$TextBox.hide_textbox()
			broom = true
		else:	
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
			$bathroomAmbience.set_volume_db(-100.0)
			bedroom = true
			$bedroomLivingRoomAmbience.set_volume_db(-5.0)
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
		$Mirror.visible = true

# ========================================================================
# ========================================================================

# BEDROOM SECTION

# ========================================================================
# ========================================================================
var remote = false
var dvdInteracted = false
var bottles = false
var livingroom = false

func black_scene(text):
	$CanvasLayer.visible = true
	$CanvasLayer2.visible = true
	$CanvasLayer/AnimationPlayer.play("new_animation")
	await get_tree().create_timer(1.5).timeout
	$TextBox.add_text(text)
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer2/AnimationPlayer.play("new_animation2")
	await get_tree().create_timer(1.5).timeout
	$TextBox.hide_textbox()
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = false

func display_text(text, delay):
	$TextBox.add_text(text)
	await get_tree().create_timer(delay).timeout
	$TextBox.hide_textbox()


func to_bathroom(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Camera2D.position.x = -90
		$Camera2D.position.y = -70
		$bedroomLivingRoomAmbience.set_volume_db(-100.0)
		$bathroomAmbience.set_volume_db(0.0)

func to_livingroom(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if livingroom:
			display_text("Into the living room.", 1.0)
			$Camera2D.position.x = 4000
			$Camera2D.position.y = 0
		elif broom:
			display_text("*Sweep the glass away.", 1.0)
			await get_tree().create_timer(1.0).timeout
			black_scene("*You sweep the glass to the side")
			await get_tree().create_timer(3.0).timeout
			display_text("Now I can go to the next room.", 2.0)
			await get_tree().create_timer(3.0).timeout
			livingroom = true

		else:
			display_text("The glass on the floor is too dangerous, I need to sweep it up somehow.", 3.0)

func drawers_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("There just seems to be clothes here.", 1.0)

func drawers_special_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("Some pills! I can finally think straight now.", 2.0)
		await get_tree().create_timer(2.0).timeout
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
				display_text("Hmm, that film seemed familiar.", 1.0)
			if dvdInteracted == true:
				display_text("I remember now! That movie gave me severe trauma.", 2.0)
		else:
			display_text("I might be able to see something if I find a remote.", 2.0)

func remote_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("This remote seems to connect to the TV.", 2.0)
		remote = true

func bed_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("The bed is neatly made. No one must have slept here yet.", 2.5)

func dvd_case_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			display_text("The Exorcist? That sounds familiar.", 1.5)
			dvdInteracted = true
			$ExorcistFlashback.visible = true
			$ExorcistFlashback.play()
			await get_tree().create_timer(8.0).timeout
			$ExorcistFlashback.visible = false
			display_text("That movie gave me some serious trauma.", 1.5)
			
var crackCutscene = false

func crack_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if crackCutscene == false:
			display_text("The crack here fits the shape of a bottle. I wonder...", 1.5)
			$wallcrack.visible = true
			$wallcrack.play()
			await get_tree().create_timer(8.0).timeout
			$wallcrack.visible = false
			display_text("I must have thrown it there.", 1.5)
			crackCutscene = true
		else:
			display_text("I must have thrown a bottle there.", 1.5)
		

#		display_text("The crack here fits the shape of the bottle. I wonder...", 2.0)
#		await get_tree().create_timer(2.0)
##			$wallcrack.visible = true
##			$wallcrack.play()
##			await get_tree().create_timer(7.0)
##			$wallcrack.visible = false
##			await get_tree().create_timer(7.0)
#		display_text("I must have thrown it at the wall.", 2.0)
##		elif bottles == false:
##			display_text("I wonder what made this crack in the wall.", 1.5)


func bottles_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		bottles = true
		display_text("Some bottles here are shattered. The ground is covered in glass here.", 2.5)

func picture_frame_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("I remember this picture! It was the day before I had to go to college.", 2.5)
		$FamilyFlashback.visible = true
		$FamilyFlashback.play()
		await get_tree().create_timer(13.5)
		$FamilyFlashback.visible = false

# ==================================================
# ==================================================
# LIVING ROOM SECTION
# ==================================================
# ==================================================

var charger = false
var phone = false
var dishes = false
var shoes = false
var phoneCutscene = false

func book_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		display_text("A book my mom was reading yesterday.", 1.5)

func shoe_rack_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if shoes == false:
			display_text("There aren't any shoes on the shoe rack. I wonder what happened...", 2.0)
			await get_tree().create_timer(2.0).timeout
			black_scene("I recall hearing footsteps at some point...")
			await get_tree().create_timer(4.5).timeout
			$LivingRoom/Shoes.visible = true
			$LivingRoom/Shoes.play()
			await get_tree().create_timer(7.0).timeout
			$LivingRoom/Shoes.visible = false
			display_text("They must have left in a hurry.", 2.0)
			shoes = true
		else:
			display_text("They must have left in a hurry.", 2.0)

func dishes_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if dishes == false:
			dishes = true
			display_text("The dishes are a mess.", 1.0)
			await get_tree().create_timer(1.0).timeout
			black_scene("I wonder what happened?")
			await get_tree().create_timer(4.5).timeout
			$LivingRoom/FamilyDinner.visible = true
			$LivingRoom/FamilyDinner.play()
			await get_tree().create_timer(15.0).timeout
			$LivingRoom/FamilyDinner.visible = false
			display_text("I remember now. I ran to the living room after that Excorcist scene.", 3.0)

		else:
			display_text("The dishes are a mess.", 1.5)

func bandaid_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if dishes:
			display_text("My outburst must had gotten someone hurt.", 2.0)
		else:
			display_text("Did someone get hurt here?", 1.5)

func phone_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if phone and charger:
			display_text("I can charge the phone with the charger on the lamp.", 2.0)
			await get_tree().create_timer(2.0).timeout
		elif phone:
			display_text("I need to find a charger.", 1.0)
			await get_tree().create_timer(1.0).timeout
		elif charger:
			display_text("The phone is dead, but I remember finding a charger somewhere.", 1.5)
			await get_tree().create_timer(1.5).timeout
			phone = true
		else:
			display_text("The phone's dead. I need to find a charger.", 1.5)
			await get_tree().create_timer(1.5).timeout
			phone = true

func lamp_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if phone and !phoneCutscene:
			display_text("There's a charging cabel here. Now I can charge the phone and check what's in it.", 2.5)
			await get_tree().create_timer(2.5).timeout
			charger = true
			phoneCutscene = true
			# PLAY CUTSCENE
			black_scene("Let's check whats on it.")
			await get_tree().create_timer(4.5).timeout
			$LivingRoom/PhoneCutscene.visible = true
			$LivingRoom/PhoneCutscene.play()
			await get_tree().create_timer(17.0).timeout
			$LivingRoom/PhoneCutscene.visible = false
		else:
			display_text("There's a charging cable attached to this lamp.", 1.5)
			await get_tree().create_timer(1.5).timeout
			charger = true
		
		



		

		

