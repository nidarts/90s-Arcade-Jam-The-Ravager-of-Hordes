extends Control
class_name ResultMenu

@onready var win_lose = $"Container/VBoxContainer/Win-Lose"
@onready var score_result = $Container/VBoxContainer/Score/ScoreResult

func _ready():
	GAMEMANAGER.result_screen = self
	GAMEMANAGER.player_die.connect(you_lose)
	GAMEMANAGER.player_win.connect(you_lose)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")

func _on_again_pressed():
#		get_tree().change_scene_to_file("res://scenes/game.tscn")
	GAMEMANAGER.game.reload_full_game()


func you_win():
	win_lose.set_text("YOU WIN!")
	score_result.set_text(str(GAMEMANAGER.game_points))

func you_lose():
	win_lose.set_text("YOU LOSE!")
	score_result.set_text(str(GAMEMANAGER.game_points))
