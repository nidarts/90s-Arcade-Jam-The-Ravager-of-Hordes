extends Area3D
class_name PointToNextChallenge

@export var next_path : PathFollow3D
@export var next_pathes_remote : RemoteTransform3D
@export var time_to_take_solution : float = 5.0

#@export_category("В яку строну потрібно повернути персонажа в точці зупинки")
# В яку строну потрібно повернути персонажа в точці зупинки
@export var player_target_rotation : Vector3

# Скільки треба знищити ворогів до наступного руху
@export var kills_needed_to_go : int

# Всі точки спавна які є в наявності для цього тригера
@export var all_spawners_for_this_point : Array[EnemySpawner]
# Час між спавном при вході в триггер
@export var time_before_spawn : float = 2.0

# Рандомна точка наступного спавну
var random_point_to_spawn = RandomNumberGenerator.new()
var what_point_use = 0

var current_spawn_count : int = 0

@onready var wait_solution = $Wait


func _ready():
	wait_solution.wait_time = time_to_take_solution


func _on_body_entered(body):
	if body is Player:
		body.rotate_to_target(player_target_rotation)
		wait_solution.start()
		
		

# TO DO:
# ФУНКЦІЮ яка буде врховувати скільки ворогів треба вбити
# чи яке виконати завдання щоб рухатись далі

# Поворот камери на певні ділянки за допомогою твінів

"""
ТАК МИ МОЖЕМО ЗАДАВАТИ НОВИЙ ШЛЯХ, ЯКИЙ БУДЕ 
ВИЗНАЧАТИСЬ ПІСЛЯ ВХОДУ ГРАВЦЯ В ТРИГГЕР
"""
func AsignNextPath():
	if next_path == null:
		GAMEMANAGER.kills_needed = kills_needed_to_go
		return
		
	GAMEMANAGER.game.current_path = next_path
	GAMEMANAGER.game.current_remote = next_pathes_remote
	GAMEMANAGER.kills_needed = kills_needed_to_go
	
	communicate_with_enemy_spawner()

		


func _on_timer_timeout():
	AsignNextPath()


func communicate_with_enemy_spawner():
	current_spawn_count += 1
	# Чекаємо необхідну кількість часу(можемо задати через інспектор) і спавнимо ворога 
	if current_spawn_count <= kills_needed_to_go:
		random_point_to_spawn.randomize()
		what_point_use = random_point_to_spawn.randi_range(0, all_spawners_for_this_point.size()-1)
		all_spawners_for_this_point[what_point_use].spawn_enemy()
	
		await get_tree().create_timer(time_before_spawn).timeout.connect(call_again_spawn)
		

func call_again_spawn():
	communicate_with_enemy_spawner()
