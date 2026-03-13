extends Panel

var Stats = ["res://data/stats/age.tres", "res://data/stats/cleanliness.tres", "res://data/stats/happiness.tres", "res://data/stats/hunger.tres", "res://data/stats/thirst.tres"]

func _ready():
	for I in Stats:
		var statDef : StatDefinition = load(I)
		print(statDef)
