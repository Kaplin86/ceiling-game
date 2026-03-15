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

var statResourceDefs : Dictionary = {}

@export var save : SaveData = null

signal saveLoaded

func _ready():
	for I : String in statList:
		statResourceDefs[I.get_file().get_basename()] = load(I)
	
	print(statResourceDefs)
	
	
	
	
	if save == null:
		save = load("res://code/savedata-related/testSaveData.tres")
	
	for I in statResourceDefs:
		if !save.statValues.has(I):
			save.statValues[I] = statResourceDefs[I].defaultValue
	print(save.statValues)
	saveLoaded.emit()

func _process(delta):
	for I in statResourceDefs:
		if save.statValues.has(I):
			save.statValues[I] += statResourceDefs[I].PerSecond * delta * 0.25

func changeStat(statName,Value):
	if save.statValues.has(statName):
		save.statValues[statName] = clamp(Value + save.statValues[statName],statResourceDefs[statName].min_value,statResourceDefs[statName].max_value)
		
