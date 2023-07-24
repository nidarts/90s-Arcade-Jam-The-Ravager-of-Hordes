extends Node
class_name InputManager

signal weaponUp
signal weaponDown
signal shoot
signal reload
signal weapon_changed(weapon_name : String)
signal update_amo(weapon_amo : Array)

var can_auto_shoot : bool = false
var cross_cursor = preload("res://assets/sprites/croshire.png")

@onready var can_interact : bool = true

func _ready():
	Input.set_custom_mouse_cursor(cross_cursor, Input.CURSOR_ARROW, Vector2(8, 8))
	GAMEMANAGER.player_die.connect(reset_all_player_input)


func _input(event):
	if event.is_action_pressed("Exit"):
		exit()
	
	if can_interact:
		if event is InputEventMouseButton and event.is_action_pressed("Shoot"):
			shoot.emit()
			can_auto_shoot = true
		else:
			can_auto_shoot = false
		
		if event.is_action_pressed("Reload"):
			reload.emit()
		
		if event.is_action_pressed("Weapon_up"):
			weaponUp.emit()
		if event.is_action_pressed("Weapon_down"):
			weaponDown.emit()



func exit():
	get_tree().quit()


func reset_all_player_input():
	GAMEMANAGER.hud.visible = false		
	GAMEMANAGER.result_screen.visible = true
	can_interact = false
