extends Panel

var Stats = ["res://data/stats/age.tres", "res://data/stats/happiness.tres", "res://data/stats/hunger.tres", "res://data/stats/thirst.tres", "res://data/stats/cleanliness.tres"]

func _ready():
	for I in Stats:
		var statDef : StatDefinition = load(I)
		createElement(statDef)

func createElement(stat : StatDefinition):
	var newNode : PackedScene
	if stat.DisplayType == stat.DisplayTypes.NUMBER:
		newNode = load("res://scenes/statDisplays/number.tscn")
	elif stat.DisplayType == stat.DisplayTypes.BAR:
		newNode = load("res://scenes/statDisplays/bar.tscn")
	elif stat.DisplayType == stat.DisplayTypes.SPECTRUM:
		newNode = load("res://scenes/statDisplays/spectrum.tscn")
	
	var newNodeReal : Control = newNode.instantiate()
	
	$ScrollContainer/VBoxContainer.add_child(newNodeReal)
	var nameNode : Label = newNodeReal.find_child("NAME",true)
	nameNode.text = stat.DisplayName
	if stat.DisplayType == stat.DisplayTypes.NUMBER:
		var statNode : Label = newNodeReal.find_child("VALUE",true)
		statNode.text = "86"
		
	if stat.DisplayType == stat.DisplayTypes.BAR:
		var statNode : ProgressBar = newNodeReal.find_child("VALUE",true)
		statNode.value = randf_range(0,100)
		statNode.add_theme_stylebox_override("fill",StyleBoxFlat.new())
		statNode.get_theme_stylebox("fill").bg_color = Color( stat.color,0.9)
		print(stat.color)
	
