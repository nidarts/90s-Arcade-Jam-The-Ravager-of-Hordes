extends Node3D

@onready var label = $Label

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_how_to_play_pressed():
	if label.visible:
		label.visible = false
	else:
		label.visible = true


func _on_full_screen_pressed():
	if DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(3)
	elif DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(0)
