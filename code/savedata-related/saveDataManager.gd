extends Node

@export var save : SaveData = null

func _ready():
	if save == null:
		save = load("res://code/savedata-related/testSaveData.tres")
