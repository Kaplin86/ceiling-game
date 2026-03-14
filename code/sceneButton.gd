extends Button

@export var destinationScene : PackedScene

func _ready():
	pressed.connect(onPress)

func onPress():
	get_tree().change_scene_to_packed(destinationScene)
