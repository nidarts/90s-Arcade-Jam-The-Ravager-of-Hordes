extends Node
class_name GameManager

# ГЛОБАЛЬНИЙ СИГНАЛ
signal enemy_attack(value : int)
signal player_health_changed(value : int)
signal player_add_health(value: int)
signal player_add_amo(value: int)
signal player_add_win_points(value: int)

signal player_die()
signal player_win()


@onready var game : Game
@onready var player : Player
@onready var camera : PlayerCamera
@onready var result_screen : ResultMenu
@onready var hud : HUD

var game_points : int = 0:
	set(val):
		game_points = val
		player_add_win_points.emit(game_points)
	get:
		return game_points

# Поточне завдання - яку кількысть потрібно вбити, щоб перейти до наступної точки
var kills_needed : int = 0:
	set(val):
		kills_needed = val
	get :
		return kills_needed



func AddPoint(val : int):
	game_points += val

func TargetKill():
	kills_needed -= 1
