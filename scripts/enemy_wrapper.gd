extends Node3D
class_name EnemyWrapper

@onready var target_to_move : Vector3

@onready var tween_move : Tween

func _ready():
	await get_tree().create_timer(1).timeout
	beginning_move(GAMEMANAGER.new_point_to_move_enemy)

func beginning_move(point : Vector3):
	tween_move = create_tween()
	tween_move.tween_property(self, "position", point, 2.0)
	await tween_move.finished
	attack_player()
	

func attack_player():
	GAMEMANAGER.enemy_attack.emit(-1)
	waiting()
	
func waiting():
	await get_tree().create_timer(2.0).timeout
	attack_player()
