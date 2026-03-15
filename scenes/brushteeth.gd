extends Node2D

var progress = 0
var dist

func _process(delta):
	dist = $Toothbrush.global_position - get_global_mouse_position()
	$Toothbrush.global_position = get_global_mouse_position()
	if $Toothbrush/Area2D.get_overlapping_areas().size() != 0 and dist != Vector2.ZERO:
		print("h")
		$FreesoundCommunity20131203RubbingToothbrushWallZoomh2Nxy87303.volume_linear = 50
	else:
		$FreesoundCommunity20131203RubbingToothbrushWallZoomh2Nxy87303.volume_linear = 0
