extends Node3D
class_name EnemyWrapper

@onready var target_to_move : Vector3

@onready var tween_move : Tween

@onready var animation_player = $AnimationPlayer
@onready var collision_shape_3d = $CollisionShape3D


var enemy_health : int = 6
var random_state = RandomNumberGenerator.new()
var random_player_damage = RandomNumberGenerator.new()

@export_category("Налаштування для щвидкості атаки та рандомізації пошкодження")
@export var wait_before_next_attack : float = 1.0
@export var min_player_damage : int = 1
@export var max_player_damage : int = 11

func _ready():
	GAMEMANAGER.player_die.connect(reset_enemy)

func init(point_value: Vector3):
	self.target_to_move = point_value
# Повертаэмо в сторону фынальноъ точки
	rotate_to_target(point_value)
	
	beginning_move(target_to_move)
	

func beginning_move(point : Vector3):
	animation_player.play("Handgun_Run01 - Forward")
	tween_move = create_tween()
	tween_move.tween_property(self, "position", point, 2.0)
	await tween_move.finished
# Повертаємо в сторону гравця
	rotate_to_target(GAMEMANAGER.player.global_transform.origin)
	attack_player()
	

func attack_player():
	if enemy_health > 0:
		random_player_damage.randomize()
		GAMEMANAGER.enemy_attack.emit(-random_player_damage.randi_range(min_player_damage, max_player_damage))
		
		animation_player.set_blend_time("Handgun_Run01 - Forward", "Handgun_Shot01", 1.0)
		animation_player.play("Handgun_Shot01")
		await animation_player.animation_finished
		waiting(wait_before_next_attack)
	
	
func waiting(val : float):
	await get_tree().create_timer(val).timeout
	attack_player()


func TakeDamage(val : int):
	enemy_health -= val
	random_state.randomize()
	var what_state_use = random_state.randi_range(0, 1)
	
	if tween_move.is_running():
		tween_move.kill()
	
	if enemy_health <= 0:
		collision_shape_3d.disabled = true
		animation_player.play("Handgun_Death03")
		await animation_player.animation_finished
		
		GAMEMANAGER.TargetKill()
		GAMEMANAGER.AddPoint(100)
		
		queue_free()
#		animation_player.stop(true)
		return
	else:
		animation_player.play("Handgun_TakeDamage01")
		await animation_player.animation_finished
		if enemy_health > 0:
			if what_state_use == 0:
				# Повертаємо в сторону гравця
				rotate_to_target(GAMEMANAGER.player.global_transform.origin)
				attack_player()
			else:
				beginning_move(target_to_move)
	

func rotate_to_target(target_vector : Vector3):
#	self.look_at(GAMEMANAGER.player.global_transform.origin, Vector3.UP)
	self.look_at(target_vector, Vector3.UP)
	self.rotate_object_local(Vector3.UP, 3.14)


func reset_enemy():
	if tween_move.is_running():
		tween_move.kill()
	animation_player.play("Handgun_Idle01_Action01")
	await animation_player.animation_finished
	queue_free()	
