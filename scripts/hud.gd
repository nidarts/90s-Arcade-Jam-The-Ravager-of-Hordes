extends Control

@onready var hp = $CanvasLayer/VBoxContainer/PlayerStat/HP
@onready var points = $CanvasLayer/VBoxContainer/PlayerStat/Points
@onready var amo = $CanvasLayer/VBoxContainer/WeaponStat/Amo
@onready var current_weapon = $CanvasLayer/VBoxContainer/WeaponStat/CurrentWeapon


func _ready():
	INPUTMANAGER.weapon_changed.connect(update_current_weapon)
	INPUTMANAGER.update_amo.connect(update_amo)

func update_hP():
	pass
	
func  update_points():
	pass
	
func update_amo(weapon_amo : Array):
	amo.set_text(str(weapon_amo[0]) + " / " + str(weapon_amo[1]))

func update_current_weapon(weapon_name : String):
	current_weapon.set_text(weapon_name)
