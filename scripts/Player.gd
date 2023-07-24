extends Node3D
class_name Player

@export var player_health : int = 100

func _ready():
	GAMEMANAGER.player = self
	GAMEMANAGER.enemy_attack.connect(change_damage)
	GAMEMANAGER.player_add_health.connect(change_damage)


func change_damage(hp_val : int):
	player_health += hp_val
	player_health = min(player_health, 100)
	GAMEMANAGER.player_health_changed.emit(player_health)

	
# ПОВОРОТ ПЕРСОНАЖА НА ТОЧЦІ-ТРИГЕРІ, КУДИ ВІН ПРИЙШОВ
func rotate_to_target(val: Vector3):
	var rotate_tween := create_tween()
#	rotate_tween.tween_property(self, "rotation_degrees", val, 2.0)
	rotate_tween.tween_property(self, "rotation_degrees", val, 1.0).from_current()
#	rotate_tween.tween_property(self, "rotation_degrees", val, 2.0).set_ease(Tween.EASE_IN_OUT)
#	rotate_tween.tween_property(self, "rotation_degrees", val, 2.0).set_delay(2.0)
