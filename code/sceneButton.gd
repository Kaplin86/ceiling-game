extends Button

@export var destinationScene : String

func _ready():
	pressed.connect(onPress)

func onPress():
	get_tree().change_scene_to_file(destinationScene)
