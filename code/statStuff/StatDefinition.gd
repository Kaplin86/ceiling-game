extends Resource
class_name StatDefinition

@export var DisplayName : String

enum DisplayTypes {
	NUMBER,
	BAR,
	SPECTRUM
}

@export var DisplayType : DisplayTypes
@export var min_value : float = 0
@export var max_value : float = 100
@export var color : Color = Color(0.914, 0.671, 0.0, 1.0)
@export var defaultValue = 1

@export_category("SpectrumStuff")
@export var LowerName : String
@export var TotalName : String
@export_category("Change")
@export var PerSecond : float = 0

func _to_string():
	return DisplayName + " definition"
