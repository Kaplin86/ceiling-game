extends Sprite2D
class_name CeilingNode

var squeakSounds = ["res://sfx/freesound_community-squeaky-toy-1-6059.mp3","res://sfx/freesound_community-squeaky-toy-4-43608.mp3","res://sfx/squeak_Q72c7Tg.mp3"]

func _process(delta):
	scale.y = lerp(scale.y,scale.x,delta * 6)

func _on_button_pressed():
	scale.y = scale.x * 0.8
	$sqeak.stream = load(squeakSounds.pick_random())
	$sqeak.play()
	$sqeak.pitch_scale = randf_range(0.95,1.05)
