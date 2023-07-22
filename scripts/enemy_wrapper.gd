extends Node3D
class_name EnemyWrapper

@onready var target_to_move : Vector3

@onready var tween_move : Tween

@onready var animation_player = $AnimationPlayer


func init(point_value: Vector3):
	self.target_to_move = point_value
	beginning_move(target_to_move)
	

func beginning_move(point : Vector3):
	animation_player.play("Handgun_Run01 - Forward")
	tween_move = create_tween()
	tween_move.tween_property(self, "position", point, 2.0)
	await tween_move.finished
	attack_player()
	

func attack_player():
	animation_player.set_blend_time("Handgun_Run01 - Forward", "Handgun_Shot01", 1.0)
	animation_player.play("Handgun_Shot01")
	await animation_player.animation_finished
	GAMEMANAGER.enemy_attack.emit(-1)
	waiting(2.0)
	
	
	
func waiting(val : float):
	await get_tree().create_timer(val).timeout
	attack_player()
