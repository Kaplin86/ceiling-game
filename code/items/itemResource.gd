extends Resource
class_name Item

@export var name : String
@export_multiline  var description : String
@export var texture : Texture
@export var edible : bool = false
@export var onEatStats : Dictionary[String, float] = {}

func _to_string():
	return name
