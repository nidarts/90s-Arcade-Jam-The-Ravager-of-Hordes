extends Control

@onready var hp = $CanvasLayer/HP
@onready var points = $CanvasLayer/Points
@onready var amo = $CanvasLayer/HBoxContainer/Amo
@onready var current_weapon = $CanvasLayer/CurrentWeapon
@onready var weapon_ico = $CanvasLayer/WeaponIco


func _ready():
	INPUTMANAGER.weapon_changed.connect(update_current_weapon)
	INPUTMANAGER.update_amo.connect(update_amo)
	GAMEMANAGER.player_health_changed.connect(update_hp)
	GAMEMANAGER.player_add_win_points.connect(update_points)

func update_hp(hp_val : int):
	hp.set_text(str(hp_val))
	var size_tween := create_tween()
	
	size_tween.tween_property(hp, "scale", Vector2.ONE * 1.5, 0.2)
	size_tween.tween_property(hp, "scale", Vector2.ONE, 0.1)
	
	
func update_points(val : int):
	points.set_text(str(val))
	var points_tween := create_tween()
	
	points_tween.tween_property(points, "scale", Vector2.ONE * 1.5, 0.1)
	points_tween.tween_property(points, "scale", Vector2.ONE, 0.1)
	
func update_amo(weapon_amo : Array):
	amo.set_text(str(weapon_amo[0]) + " / " + str(weapon_amo[1]))
	var amo_tween := create_tween()
	
	amo_tween.tween_property(amo, "scale", Vector2.ONE * 1.5, 0.1)
	amo_tween.tween_property(amo, "scale", Vector2.ONE, 0.1)

func update_current_weapon(weapon_name : String):
#	current_weapon.set_text(weapon_name)
	
	if weapon_name == "Gun":
		weapon_ico.texture.region = Rect2(0,0,128,128)
	if weapon_name == "Machinegun":
		weapon_ico.texture.region = Rect2(256,0,128,128)
	if weapon_name == "Shotgun":
		weapon_ico.texture.region = Rect2(128,0,128,128)
		
	var current_weapon_tween := create_tween()
	
#	current_weapon_tween.tween_property(current_weapon, "scale", Vector2.ONE * 1.5, 0.1)
#	current_weapon_tween.tween_property(current_weapon, "scale", Vector2.ONE, 0.1)
	
	current_weapon_tween.tween_property(weapon_ico, "scale", Vector2.ONE * 1.5, 0.1)
	current_weapon_tween.tween_property(weapon_ico, "scale", Vector2.ONE, 0.1)
