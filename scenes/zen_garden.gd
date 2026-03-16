extends Node2D

@export var planters : Array[Node]
@export var validPlanters = []
var cropType = []

func _process(delta):
	SaveDataManager.changeStat("sunlight",5 * delta)
	
	for I in planters.size():
		if validPlanters[I]:
			var plntr = planters[I]
			var timerText : Label = plntr.get_node("timer")
			timerText.text = ""
			
			plntr.get_node("plant").visible = true
			plntr.get_node("plant").texture = load("res://images/items/"+cropType[I]+".png")
			
			if plntr.get_node("Button").button_pressed:
				validPlanters[I] = false
				SaveDataManager.save.planterTimes[I] = Time.get_unix_time_from_system()
			
		else:
			var plntr = planters[I]
			var timerText : Label = plntr.get_node("timer")
			plntr.get_node("plant").visible = false
			var timeElapsed = Time.get_unix_time_from_system() - SaveDataManager.save.planterTimes[I] 
			var timeRemaining = ((I + 1) * 40) - timeElapsed
			var minutes = int(timeRemaining / 60)
			var seconds = int(timeRemaining) % 60
			var time_string = "%02d:%02d" % [minutes, seconds]
			timerText.text = time_string
			if timeRemaining <= 0:
				validPlanters[I] = true
				cropType[I] = ["ceiling","apple","flower"].pick_random()
		
	

func _ready():
	if SaveDataManager.save.planterTimes == []:
		for I in planters.size():
			var time = Time.get_unix_time_from_system()
			SaveDataManager.save.planterTimes.append(time)
	print(SaveDataManager.save.planterTimes)
	
	for I in planters.size():
		validPlanters.append(false)
		cropType.append("")
