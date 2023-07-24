extends Marker3D
class_name EnemySpawner

@export var target_move_position : Array[Marker3D]
@export var enemy_to_spawn : PackedScene

var random_point_to_spawn = RandomNumberGenerator.new()


func spawn_enemy():
	random_point_to_spawn.randomize()
	var what_point_use = 0
	if target_move_position.size() > 1:
		what_point_use = random_point_to_spawn.randi_range(0, target_move_position.size()-1)
	else:
		what_point_use = 0
	
	var new_enemy : EnemyWrapper = enemy_to_spawn.instantiate()
	new_enemy.position = self.global_position
#	get_parent().add_child(new_enemy)
	get_tree().root.add_child(new_enemy)
	new_enemy.init(target_move_position[what_point_use].global_position)
#	GAMEMANAGER.new_point_to_move_enemy = target_move_position.global_position


# В спавнері повино відбуватись
# - бути набір точок, до яких потрібно рухатись
# - ці точки обираються рандомно і передаються ворогові
# - в спавн повина передавати інформацію скільки і коли спавнити
# - Коли потрібно зупинитись спавнити
