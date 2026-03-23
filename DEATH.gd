extends Node2D

func _process(delta):
	for I in SaveDataManager.statResourceDefs:
		if SaveDataManager.save.statValues[I] <= SaveDataManager.statResourceDefs[I].min_value * 0.1:
			if randi_range(0,50) == 5:
				die(SaveDataManager.statResourceDefs[I])

func die(stat : StatDefinition):
	$Death.visible = true
	$Death/death.text = "Apon further inspection, it was revealed that your ceiling died from (or the lack thereof): " + str(stat.DisplayName) + " at age " + str(int(SaveDataManager.save.statValues.age))
	SaveDataManager.delete_save()
	get_tree().paused = true
