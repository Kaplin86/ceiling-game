extends Node2D

var progress = 0
var dist

var done = false

func _process(delta):
	
	if done:
		return
		
	dist = $Brush.global_position - get_global_mouse_position()
	$Brush.global_position = get_global_mouse_position()
	if $Brush/Area2D.get_overlapping_areas().size() != 0 and dist != Vector2.ZERO:
		progress += delta * 1.5
		$sound.volume_linear = 1.0
	else:
		$sound.volume_linear = 0.0
	
	$ProgressBar.value = progress
	if progress < $ProgressBar.max_value:
		progress -= 0.5 * delta
	else:
		done = true
		$Ceiling.clickable = true
		$Ceiling._on_button_pressed()
		await get_tree().create_timer(0.5).timeout
		SaveDataManager.changeStat("cleanliness",25)
		get_tree().change_scene_to_file("res://main.tscn")
		
		
		
		
	progress = max(progress,0)
