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

var familyInt = false
var bathtubInt = false
var excorcistInt = false
var tvInt = false
var dishesInt = false
var shoesInt = false
var bandaidInt = false
var pillsInt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position.x = 6000
	$Camera2D.position.y = 0
	$CanvasLayer.visible = false
	$MirrorCrack.visible = false
	$BackArrow.visible = false
	$VideoStreamPlayer.visible = false
	toggle_visiblity_off()
	$Bathroom2/IntroScene.visible = true
	$Bathroom2/IntroScene.play()
	await get_tree().create_timer(9.0).timeout
	$TextBox.add_text("How did I end up in the spare bathroom? How long have I been here? Where did everybody go?")
	await get_tree().create_timer(4.0).timeout
	$TextBox.hide_textbox()
	$Bathroom2/IntroScene.visible = false
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
			$TextBox.add_text("	Did I break this mirror?")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$Bathroom2/MirrorBreak.visible = true
			$Bathroom2/MirrorBreak.play()
			await get_tree().create_timer(5.5).timeout
			$TextBox.add_text("Oh... it was me.")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$Bathroom2/MirrorBreak.visible = false
			checkedMirror = true
		else:
			$TextBox.add_text("Lets see whats in the cabinet.")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$Camera2D.position.x = 8000
			$Camera2D.position.y = 0

func _on_area_close_mirror_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Camera2D.position.x = 6000
		$Camera2D.position.y = 0
		$TextBox.hide_textbox()
		

func _on_area_pills_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		pillsFound = true
		$TextBox.add_text("Oh damn it my pills. I must have forgotten to take them.")
		await get_tree().create_timer(2.0).timeout
		$TextBox.add_text("Last time I forgot to take them I blacked out for days. I just can’t control myself without them.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.add_text("I need to figure out what happened and make sure everybody is okay.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()
		pillsInt = true


func _on_area_screw_driver_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if handleInteraction:
			screwDriverFound = true
			if screwsFound:
				$TextBox.add_text("I can use this to fix the handle now.")
			else:
				$TextBox.add_text("I can use this to fix the handle. I just need some screws.")
			await get_tree().create_timer(2.5).timeout			
			$"Bathroom2/1-bathroomMirrorCabinet/1-screwdriver".visible = false
		else:
			$TextBox.add_text("An ordinary screwdriver. Don't know what I'd use it for.")
			await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()		

var tubhands = false
func _on_area_crack_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$TextBox.add_text("How did this crack get here?")
		await get_tree().create_timer(2.0).timeout
		$TextBox.hide_textbox()
		$"Bathroom2/1-bathtub".visible = true
		$Camera2D.position.x = 10000
		$Camera2D.position.y = 0
		$TextBox.add_text("What happened that made me so angry? Did I break all of this?")
		await get_tree().create_timer(2.0).timeout
		$TextBox.hide_textbox()
		tubhands = true


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
			$TextBox.add_text("How did this happen? It seems like it was broken from the outside. Did somebody lock me in here?")
			handleInteraction = true
			await get_tree().create_timer(3.0).timeout
			$TextBox.hide_textbox()
			$TextBox.add_text("I can’t open the door without fixing this handle with screws.")
			await get_tree().create_timer(1.5).timeout
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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and tubhands:
		$"Bathroom2/1-bathtub/1b-bathtub(hands)".visible = true
		await get_tree().create_timer(1.0).timeout
		$TextBox.add_text("That blood is definitely from my injuries.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.hide_textbox()
		$"Bathroom2/1-bathtub/1b-bathtub(hands)".visible = false
		bathtubInt = true



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
			$Camera2D.position.x = 6000
			$Camera2D.position.y = 0
			$"Bathroom2/1-bathtub".visible = false

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
	$CanvasLayer/AnimationPlayer.play("new_animation")
	await get_tree().create_timer(1.5).timeout
	$TextBox.add_text(text)
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = true
	$CanvasLayer2/AnimationPlayer.play("new_animation2")
	await get_tree().create_timer(1.5).timeout
	$TextBox.hide_textbox()
	$CanvasLayer2.visible = false

func black_scene_in():
	$CanvasLayer.visible = true
	$CanvasLayer/AnimationPlayer.play("new_animation")
	await get_tree().create_timer(1.5).timeout

func black_scene_out():
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = true
	$CanvasLayer2/AnimationPlayer.play("new_animation2")
	await get_tree().create_timer(1.5).timeout
	$CanvasLayer2.visible = false
	
func display_text(text, delay):
	$TextBox.add_text(text)
	await get_tree().create_timer(delay).timeout
	$TextBox.hide_textbox()


func to_bathroom(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$Camera2D.position.x = 6000
		$Camera2D.position.y = 0
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
			$Camera2D.position.x = 4000
			$Camera2D.position.y = 0
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

func tv_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		tvInt = true
		if remote:
			display_text("*Hits play*", 1.0)
			$ToBathroom.visible = false
			$ToLivingRoom.visible = false
			$MovieClip.visible = true
			$MovieClip.play()
			await get_tree().create_timer(18.0).timeout
			$MovieClip.visible = false
			$ToBathroom.visible = true
			$ToLivingRoom.visible = true
			display_text("We stopped right in the middle of the movie. This scene always freaked me out so much.", 2.5)
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
			excorcistInt = true
			display_text("The Exorcist? Mark used to force me to watch this movie as a kid, I seriously hate it.", 2.5)
			dvdInteracted = true
			$ToBathroom.visible = false
			$ToLivingRoom.visible = false
			$ExorcistFlashback.visible = true
			$ExorcistFlashback.play()
			await get_tree().create_timer(8.0).timeout
			$ExorcistFlashback.visible = false
			$ToBathroom.visible = true
			$ToLivingRoom.visible = true
			display_text("That movie gave me some serious trauma. I can’t believe I let them put this on.", 1.5)
			
var crackCutscene = false

func crack_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if crackCutscene == false:
			display_text("The crack here fits the shape of a bottle. I wonder...", 1.5)
			$ToBathroom.visible = false
			$ToLivingRoom.visible = false
			$wallcrack.visible = true
			$wallcrack.play()
			await get_tree().create_timer(8.0).timeout
			$wallcrack.visible = false
			$ToBathroom.visible = true
			$ToLivingRoom.visible = true
			display_text("Something must have set me off and made me throw those bottles. I hope I didn’t hurt anybody.", 2.5)
			crackCutscene = true
		else:
			display_text("Something must have set me off and made me throw those bottles. I hope I didn’t hurt anybody.", 2.5)


func bottles_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		bottles = true
		display_text("Some bottles here are shattered. The ground is covered in glass here.", 2.5)

func picture_frame_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		familyInt = true
		$TextBox.add_text("I remember this picture! It was the first time we came up here to the cabin back when we were kids.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.add_text("I’ve always loved being up here with our family. It holds a lot of tough memories though.")
		await get_tree().create_timer(2.5).timeout
		$TextBox.add_text("I had my first incident here when we were watching one of Mark’s stupid horror movies.")
		await get_tree().create_timer(2.0).timeout
		$TextBox.add_text("At least I have my meds now to help me control everything.")
		await get_tree().create_timer(1.5).timeout
		$TextBox.hide_textbox()

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
		shoesInt = true
		if shoes == false:
			display_text("There aren’t any shoes on the rack.", 1.0)
			await get_tree().create_timer(2.0).timeout
			black_scene("I recall hearing footsteps at some point...")
			await get_tree().create_timer(4.5).timeout
			$LivingRoom/Shoes.visible = true
			$LivingRoom/Shoes.play()
			await get_tree().create_timer(7.0).timeout
			$LivingRoom/Shoes.visible = false
			display_text("Everybody must have left in a hurry.", 1.0)
			shoes = true
		else:
			display_text("They must have left in a hurry.", 2.0)

func dishes_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dishesInt = true
		if dishes == false:
			dishes = true
			display_text("The last thing I can remember is eating dinner.", 1.5)
			await get_tree().create_timer(2.0).timeout
			black_scene_in()
			await get_tree().create_timer(1.5).timeout
			$TextBox.add_text("*Mark: We’re thinking of watching a scary movie tonight Lindsay, what do you think?*")
			await get_tree().create_timer(2.5).timeout
			$TextBox.add_text("*Me: You know how those upset me. Can’t we just watch something happy for once?*")
			await get_tree().create_timer(2.5).timeout
			$TextBox.add_text("*Mark: Come on sis, for old times sake? What could go wrong?*")
			await get_tree().create_timer(2.0).timeout
			$TextBox.hide_textbox()
			$LivingRoom/FamilyDinner.visible = true
			black_scene_out()
			$LivingRoom/FamilyDinner.play()
			await get_tree().create_timer(15.0).timeout
			$LivingRoom/FamilyDinner.visible = false
			display_text("Apparently everything.", 3.0)
		else:
			display_text("The dishes are a mess.", 1.5)

func bandaid_interact(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		bandaidInt = true
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

func finish(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var interactions = [familyInt, bathtubInt, excorcistInt, tvInt, dishesInt, shoesInt, bandaidInt, phoneCutscene]

		var trueCount = 0
		for interaction in interactions:
			if interaction:
				trueCount += 1
		if trueCount > 5:
			display_text("I think I've gathered enough information. Time to head out.", 2.0)
		else:
			display_text("I shouldn't leave yet. There are still some missing clues to be discovered.", 2.0)
		
		



		

		

