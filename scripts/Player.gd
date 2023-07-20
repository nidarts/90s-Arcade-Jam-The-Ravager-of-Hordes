extends Node3D
class_name Player

@export var player_health : int = 100

func _ready():
	GAMEMANAGER.player = self
	GAMEMANAGER.enemy_attack.connect(change_damage)


func change_damage(hp_val : int):
	player_health += hp_val
	GAMEMANAGER.player_health_changed.emit(player_health)
