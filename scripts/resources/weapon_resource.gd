extends Resource
class_name Weapon_Resource

@export var weapon_name : String
@export var activate_animation : String = "weapon_activate"
@export var shoot_animation : String = "weapon_shoot"
@export var reload_animation : String = "weapon_reload"
@export var deactivate_animation : String = "weapon_deactivate"
@export var out_of_amo_animation : String = "weapon_out"

@export var current_amo : int
@export var reserve_amo : int
@export var magazine : int
@export var max_amo : int

@export var auto_fire : bool
