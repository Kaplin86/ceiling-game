extends Node

var statList = [
	"res://data/stats/age.tres",
	"res://data/stats/happiness.tres",
	"res://data/stats/hunger.tres",
	"res://data/stats/thirst.tres",
	"res://data/stats/connection.tres",
	"res://data/stats/dental.tres",
	"res://data/stats/cleanliness.tres",
	"res://data/stats/coolness.tres",
	"res://data/stats/sunlight.tres",
	
	
	
	"res://data/stats/foodStats/carbs.tres",
	"res://data/stats/foodStats/fruits.tres",
	"res://data/stats/foodStats/protein.tres",
	"res://data/stats/foodStats/sugar.tres",
	"res://data/stats/foodStats/veggies.tres",
	
	
	"res://data/stats/dndStats/strength.tres",
	"res://data/stats/dndStats/dexterity.tres",
	"res://data/stats/dndStats/constitution.tres",
	"res://data/stats/dndStats/intelligence.tres",
	"res://data/stats/dndStats/wisdom.tres",
	"res://data/stats/dndStats/charisma.tres",
	
	
	
	
]

var statResourceDefs : Dictionary[String,StatDefinition] = {}

@export var save : SaveData = null

signal saveLoaded

func _ready():
	
	
	
	for I : String in statList:
		statResourceDefs[I.get_file().get_basename()] = load(I)
	
	print(statResourceDefs)
	
	
	if ResourceLoader.exists("user://ceilingSaveData.tres"):
		var loaded_resource = ResourceLoader.load("user://ceilingSaveData.tres", "", ResourceLoader.CACHE_MODE_IGNORE)
		if loaded_resource is SaveData:
			save = loaded_resource

	
	if save == null:
		save = load("res://code/savedata-related/testSaveData.tres")
	
	for I in statResourceDefs:
		if !save.statValues.has(I):
			save.statValues[I] = statResourceDefs[I].defaultValue
	print(save.statValues)
	saveLoaded.emit()
	
	var newTimer = Timer.new()
	add_child(newTimer)
	newTimer.wait_time = 5
	newTimer.autostart = true
	newTimer.timeout.connect(doSave)
	newTimer.start()

func doSave():
	ResourceSaver.save(save, "user://ceilingSaveData.tres")
	print("SAVE")

func delete_save():
	var path = "user://ceilingSaveData.tres"
	if FileAccess.file_exists(path):
		var err = DirAccess.remove_absolute(path)

func _process(delta):
	for I in statResourceDefs:
		if save.statValues.has(I):
			save.statValues[I] += statResourceDefs[I].PerSecond * delta * 0.25
			save.statValues[I] = clamp(save.statValues[I],statResourceDefs[I].min_value,statResourceDefs[I].max_value)

func changeStat(statName,Value):
	if save.statValues.has(statName):
		save.statValues[statName] = clamp(Value + save.statValues[statName],statResourceDefs[statName].min_value,statResourceDefs[statName].max_value)
		
