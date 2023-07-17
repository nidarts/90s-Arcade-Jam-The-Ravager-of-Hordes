extends Area3D
class_name PointToNextChallenge

@export var next_path : PathFollow3D
@export var next_pathes_remote : RemoteTransform3D
@export var time_to_take_solution : float = 5.0

@onready var wait_solution = $Wait

func _ready():
	wait_solution.wait_time = time_to_take_solution

func _on_body_entered(body):
	if body is Player:
		wait_solution.start()

# TO DO:
# ФУНКЦІЮ яка буде врховувати скільки ворогів треба вбити
# чи яке виконати завдання щоб рухатись далі

"""
ТАК МИ МОЖЕМО ЗАДАВАТИ НОВИЙ ШЛЯХ, ЯКИЙ БУДЕ 
ВИЗНАЧАТИСЬ ПІСЛЯ ВХОДУ ГРАВЦЯ В ТРИГГЕР
"""
func AsignNextPath():
	GAMEMANAGER.game.current_path = next_path
	GAMEMANAGER.game.current_remote = next_pathes_remote

func _on_timer_timeout():
	AsignNextPath()
