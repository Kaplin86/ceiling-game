extends Node2D

func _ready():
	var items = SaveDataManager.save.inventory
	for I in items:
		if I.edible:
			var newButton = Button.new()
			var texture : CompressedTexture2D = I.texture
			var image = texture.get_image()
			image.resize(150,150)
			var newtexture = ImageTexture.create_from_image(image)
			newButton.icon = newtexture
			newButton.set_meta("item",I)
			
			$GridContainer.add_child(newButton)
			newButton.mouse_entered.connect(showThing.bind(I))
			newButton.pressed.connect(eat.bind(I,newButton))
			newButton.mouse_exited.connect(hideThing)

func eat(item : Item, button):
	button.queue_free()
	var newSound = load("res://sfx/nom-nom-nom_gPJiWn4.mp3")
	var newPlayer = AudioStreamPlayer.new()
	newPlayer.stream = newSound
	add_child(newPlayer)
	newPlayer.play()
	SaveDataManager.save.inventory.erase(item)
	print(SaveDataManager.save.inventory)
	
	for I in item.onEatStats:
		SaveDataManager.changeStat(I,item.onEatStats[I])
	
	await get_tree().create_timer(1.3).timeout
	$Ceiling.sqeakNoSound()

func hideThing():
	$CanvasLayer/RichTextLabel.visible = false
func showThing(item : Item):
	$CanvasLayer/RichTextLabel.visible = true
	$CanvasLayer/RichTextLabel.text = "[b]"
	$CanvasLayer/RichTextLabel.text += item.name + "[/b]"
	$CanvasLayer/RichTextLabel.text += "\n"
	$CanvasLayer/RichTextLabel.text += item.description
	$CanvasLayer/RichTextLabel.text += "\n"
	$CanvasLayer/RichTextLabel.text += "\n"
	$CanvasLayer/RichTextLabel.text += "[b]On-Eaten Effects [/b]"
	for I in item.onEatStats:
		$CanvasLayer/RichTextLabel.text += "\n"
		if SaveDataManager.statResourceDefs[I].isIncreasePositive:
			$CanvasLayer/RichTextLabel.text += I + " is increased by " + str(item.onEatStats[I])
		else:
			$CanvasLayer/RichTextLabel.text += I + " is decreased by " + str(item.onEatStats[I])
	

func _process(delta):
	$CanvasLayer/RichTextLabel.global_position = get_global_mouse_position() + Vector2(30,30)
