extends Node2D

@export var images : Array[Texture2D]

@export var descriptionOptions  : Array[String] = []

func takePhoto():
	var texture =  $SubViewportContainer/SubViewport.get_texture().get_image().duplicate()
	texture = ImageTexture.create_from_image(texture)
	$SubViewportContainer/SubViewport/TextureRect.texture = images.pick_random()
	return texture
	
func _process(delta):
	$Label2.text = "MONEY: " + str(SaveDataManager.save.money)

 
func _on_button_pressed():
	var image = takePhoto()
	var newOne : Control = load("res://scenes/ceilingtubePost.tscn").instantiate()
	$ScrollContainer/VBoxContainer.add_child(newOne)
	print(type_string(typeof(image)))
	newOne.find_child("TextureRect",true).texture = image
	newOne.find_child("RichTextLabel",true).text = descriptionOptions.pick_random()
	await RenderingServer.frame_post_draw
	$ScrollContainer.scroll_vertical = 999999999
	SaveDataManager.save.money += randi_range(3,9)
