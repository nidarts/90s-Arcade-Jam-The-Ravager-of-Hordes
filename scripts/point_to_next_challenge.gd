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
	GAMEMANAGER.game.current_path = next_path
	GAMEMANAGER.game.current_remote = next_pathes_remote
	GAMEMANAGER.kills_needed = kills_needed_to_go
	print(GAMEMANAGER.kills_needed)


func _on_timer_timeout():
	AsignNextPath()
