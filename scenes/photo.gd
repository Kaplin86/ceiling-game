extends Node2D

@export var images : Array[Texture2D]

func takePhoto():
	var texture =  $SubViewportContainer/SubViewport.get_texture().duplicate()
	$SubViewportContainer/SubViewport/TextureRect.texture = images.pick_random()
	return texture
	

 
func _on_button_pressed():
	pass
