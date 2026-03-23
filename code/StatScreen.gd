extends Control

func _ready():
	#await SaveDataManager.saveLoaded
	for I in SaveDataManager.statResourceDefs:
		createElement(SaveDataManager.statResourceDefs.get(I),SaveDataManager.save.statValues[I])

var statDefToDisplay = {}

func _process(delta):
	for I in SaveDataManager.statResourceDefs:
		updateElement(SaveDataManager.statResourceDefs.get(I),SaveDataManager.save.statValues[I])

func updateElement(stat : StatDefinition,value):
	var node = statDefToDisplay[stat]
	var valueNode = node.find_child("VALUE",true)
	
	if stat.DisplayType == stat.DisplayTypes.NUMBER:
		valueNode.text = str(round(value * 10) / 10)
		
	if stat.DisplayType == stat.DisplayTypes.BAR:
		valueNode.value = value
	
	if stat.DisplayType == stat.DisplayTypes.SPECTRUM:
		valueNode.value = value
	

func createElement(stat : StatDefinition,value):
	var node = stat
	var newNode : PackedScene
	if stat.DisplayType == stat.DisplayTypes.NUMBER:
		newNode = load("res://scenes/statDisplays/number.tscn")
	elif stat.DisplayType == stat.DisplayTypes.BAR:
		newNode = load("res://scenes/statDisplays/bar.tscn")
	elif stat.DisplayType == stat.DisplayTypes.SPECTRUM:
		newNode = load("res://scenes/statDisplays/spectrum.tscn")
	
	var newNodeReal : Control = newNode.instantiate()
	
	$ScrollContainer/VBoxContainer.add_child(newNodeReal)
	statDefToDisplay[stat] = newNodeReal
	
	var nameNode : Label = newNodeReal.find_child("NAME",true)
	nameNode.text = stat.DisplayName
	if stat.DisplayType == stat.DisplayTypes.NUMBER:
		var statNode : Label = newNodeReal.find_child("VALUE",true)
		statNode.text = str(round(value * 10) / 10)
		
	if stat.DisplayType == stat.DisplayTypes.BAR:
		var statNode : ProgressBar = newNodeReal.find_child("VALUE",true)
		statNode.value = value
		statNode.add_theme_stylebox_override("fill",StyleBoxFlat.new())
		statNode.get_theme_stylebox("fill").bg_color = Color( stat.color,0.9)
		print(stat.color)
		statNode.max_value = stat.max_value
		statNode.min_value = stat.min_value
	
	if stat.DisplayType == stat.DisplayTypes.SPECTRUM:
		var statNode : TextureProgressBar = newNodeReal.find_child("VALUE",true)
		statNode.value = value
		
		statNode.max_value = stat.max_value
		statNode.min_value = stat.min_value
		
		var textureResource : GradientTexture2D = statNode.texture_progress
		textureResource.gradient.set_color(0,stat.color.inverted())
		textureResource.gradient.set_color(1,stat.color)
		
		var lowerName : Label = newNodeReal.find_child("LOWERNAME",true)
		lowerName.text = stat.LowerName
		var totalName : Label = newNodeReal.find_child("TOTAL",true)
		totalName.text = stat.TotalName
