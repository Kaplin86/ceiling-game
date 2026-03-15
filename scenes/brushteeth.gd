extends Node2D

var progress = 0
var dist

var done = false

func _process(delta):
	
	if done:
		return
		
	dist = $Toothbrush.global_position - get_global_mouse_position()
	$Toothbrush.global_position = get_global_mouse_position()
	if $Toothbrush/Area2D.get_overlapping_areas().size() != 0 and dist != Vector2.ZERO:
		$FreesoundCommunity20131203RubbingToothbrushWallZoomh2Nxy87303.volume_linear = 50
		$Ceiling/CPUParticles2D.emitting = true
		progress += delta * 1.5
	else:
		$FreesoundCommunity20131203RubbingToothbrushWallZoomh2Nxy87303.volume_linear = 0
		$Ceiling/CPUParticles2D.emitting = false
	
	$ProgressBar.value = progress
	if progress < $ProgressBar.max_value:
		progress -= 0.5 * delta
	else:
		done = true
		$FreesoundCommunity20131203RubbingToothbrushWallZoomh2Nxy87303.volume_linear = 0
		$Ceiling.clickable = true
		$Ceiling._on_button_pressed()
		await get_tree().create_timer(0.5).timeout
		SaveDataManager.changeStat("dental",20)
		SaveDataManager.changeStat("cleanliness",5)
		get_tree().change_scene_to_file("res://main.tscn")
		
		
		
		
	progress = max(progress,0)
