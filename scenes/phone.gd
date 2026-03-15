extends Node2D

func _ready():
	$AnimationPlayer.play("kaplinCall")


func _on_animation_player_animation_finished(anim_name):
	await get_tree().create_timer(0.1).timeout
	SaveDataManager.changeStat("connection",20)
	get_tree().change_scene_to_file("res://main.tscn")
	
