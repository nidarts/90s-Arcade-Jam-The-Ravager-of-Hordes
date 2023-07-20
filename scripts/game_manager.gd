extends Node
class_name GameManager

# ГЛОБАЛЬНИЙ СИГНАЛ
signal enemy_attack(value : int)
signal player_health_changed(value : int)

@onready var game : Game
var player : Player
var camera : PlayerCamera
#var level
#var gui

var new_point_to_move_enemy : Vector3 = Vector3.ZERO
