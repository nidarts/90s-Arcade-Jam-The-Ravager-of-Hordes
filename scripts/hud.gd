extends Control

@onready var hp = $CanvasLayer/HP
@onready var points = $CanvasLayer/Points
@onready var amo = $CanvasLayer/Amo
@onready var current_weapon = $CanvasLayer/CurrentWeapon


func _ready():
	INPUTMANAGER.weapon_changed.connect(update_current_weapon)
	INPUTMANAGER.update_amo.connect(update_amo)
	GAMEMANAGER.player_health_changed.connect(update_hp)

func update_hp(hp_val : int):
	hp.set_text(str(hp_val))
	var size_tween := create_tween()
	
	size_tween.tween_property(hp, "scale", Vector2.ONE * 1.5, 0.2)
	size_tween.tween_property(hp, "scale", Vector2.ONE, 0.1)
	
	
func  update_points():
	pass
	
func update_amo(weapon_amo : Array):
	amo.set_text(str(weapon_amo[0]) + " / " + str(weapon_amo[1]))
	var amo_tween := create_tween()
	
	amo_tween.tween_property(amo, "scale", Vector2.ONE * 1.5, 0.1)
	amo_tween.tween_property(amo, "scale", Vector2.ONE, 0.1)

func update_current_weapon(weapon_name : String):
	current_weapon.set_text(weapon_name)
	var current_weapon_tween := create_tween()
	
	current_weapon_tween.tween_property(current_weapon, "scale", Vector2.ONE * 1.5, 0.1)
	current_weapon_tween.tween_property(current_weapon, "scale", Vector2.ONE, 0.1)
