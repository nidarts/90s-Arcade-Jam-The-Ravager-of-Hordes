extends Node
class_name InputManager

signal weaponUp
signal weaponDown
signal shoot


func _input(event):
	if event.is_action_pressed("Exit"):
		exit()
	
	if event is InputEventMouseButton and event.is_action_pressed("Shoot"):
		shoot.emit()
	
	if event.is_action_pressed("Weapon_up"):
		weaponUp.emit()
	if event.is_action_pressed("Weapon_down"):
		weaponDown.emit()



func exit():
	get_tree().quit()

