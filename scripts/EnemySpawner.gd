extends Marker3D
class_name EnemySpawner

@export var target_move_position : Marker3D
@export var enemy_to_spawn : PackedScene


func _ready():
	await get_tree().create_timer(15).timeout
	spawn_enemy()


func spawn_enemy():
	var new_enemy : EnemyWrapper = enemy_to_spawn.instantiate()
	new_enemy.position = self.global_position
	get_parent().add_child(new_enemy)
	GAMEMANAGER.new_point_to_move_enemy = target_move_position.global_position



# В спавнері повино відбуватись
# - бути набір точок, до яких потрібно рухатись
# - ці точки обираються рандомно і передаються ворогові
# - в спавн повина передавати інформацію скільки і коли спавнити
# - Коли потрібно зупинитись спавнити
