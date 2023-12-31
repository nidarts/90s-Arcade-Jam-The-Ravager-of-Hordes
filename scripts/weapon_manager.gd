extends Node3D
class_name Weapon_Manager


@export var _weapon_resources : Array[Weapon_Resource]
@export var start_weapon : Array[String]

@export_category("Налаштування для потужності зброї")
@export var gun_power : int = 2
@export var machinegun_power : int = 1
@export var shotgun_power : int = 3

@onready var animation_player = $AnimationPlayer

@onready var gun = $Marker3D/Gun
@onready var shotgun = $Marker3D/Shotgun
@onready var machinegun = $Marker3D/Machinegun


# треба ще зробити посилання на всі моделі зброї(коли будуть)
# щоб робити її видимою/невидимою

var current_weapon = null
# Вся зброя, яку ми зараз маємо
var weapon_stack = []
var weapon_indicator = 0
var next_weapon : String
var weapon_list = {}
# =================RAY========================
@onready var camera := GAMEMANAGER.camera
var mouse_position: Vector2
var ray_length : int = 1000


func _ready():
	initialize(start_weapon)
	INPUTMANAGER.shoot.connect(shoot)
	INPUTMANAGER.reload.connect(reload)
	INPUTMANAGER.weaponUp.connect(weapon_up)
	INPUTMANAGER.weaponDown.connect(weapon_down)
	GAMEMANAGER.player_add_amo.connect(add_amo)

func initialize(_start_weapon: Array):
	for weapon in _weapon_resources:
		weapon_list[weapon.weapon_name] = weapon
	
	for i in _start_weapon:
		weapon_stack.push_back(i)
	
	current_weapon = weapon_list[weapon_stack[0]]
	
	INPUTMANAGER.weapon_changed.emit(current_weapon.weapon_name)
	INPUTMANAGER.update_amo.emit([current_weapon.current_amo, current_weapon])
	
	enter()

func enter():
	animation_player.play(current_weapon.activate_animation)
	INPUTMANAGER.weapon_changed.emit(current_weapon.weapon_name)
	INPUTMANAGER.update_amo.emit([current_weapon.current_amo, current_weapon.reserve_amo])
	

func exit(_next_weapon: String):
	if _next_weapon != current_weapon.weapon_name:
		if animation_player.get_current_animation() != current_weapon.deactivate_animation:
			animation_player.play(current_weapon.deactivate_animation)
			next_weapon = _next_weapon
			
			await animation_player.animation_finished
			gun.visible = false
			shotgun.visible = false
			machinegun.visible = false
			
			if _next_weapon == "Gun":
				gun.visible = true
			if _next_weapon == "Machinegun":
				machinegun.visible = true
			if _next_weapon == "Shotgun":
				shotgun.visible = true
			

func _on_animation_player_animation_finished(anim_name):
	if anim_name == current_weapon.deactivate_animation:
		change_weapon(next_weapon)
	if anim_name == current_weapon.shoot_animation && current_weapon.auto_fire == true:
		if INPUTMANAGER.can_auto_shoot:
			shoot()
	
	

func change_weapon(weapon_name: String):
	current_weapon = weapon_list[weapon_name]
	next_weapon = ""
	enter()


func reload():
	if current_weapon.current_amo == current_weapon.magazine:
		return
	else:
		if !animation_player.is_playing():
			if current_weapon.reserve_amo != 0:
				animation_player.play(current_weapon.reload_animation)
				var reload_amount = min(current_weapon.magazine - current_weapon.current_amo, current_weapon.magazine, current_weapon.reserve_amo)
				current_weapon.current_amo = current_weapon.current_amo + reload_amount
				current_weapon.reserve_amo = current_weapon.reserve_amo - reload_amount
				
				INPUTMANAGER.update_amo.emit([current_weapon.current_amo, current_weapon.reserve_amo])
			else:
				animation_player.play(current_weapon.out_of_amo_animation)

func weapon_up():
	weapon_indicator = min(weapon_indicator + 1, weapon_stack.size()-1)
	exit(weapon_stack[weapon_indicator])


func weapon_down():
	weapon_indicator = max(weapon_indicator-1, 0)
	exit(weapon_stack[weapon_indicator])




func shoot():
	var space_state = get_world_3d().direct_space_state
	mouse_position = camera.get_viewport().get_mouse_position()
	var raycast_origin = camera.project_ray_origin(mouse_position)
	var raycast_target = raycast_origin + camera.project_ray_normal(mouse_position) * ray_length
	var physics_raycast_query = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_target, 2)
	var raycast_result = space_state.intersect_ray(physics_raycast_query)
	
	
	
	if raycast_result.is_empty():
		if current_weapon.current_amo != 0:
			play_shoot_animation()
		else:
			reload()
	else:
		var col = raycast_result.collider
		if current_weapon.current_amo != 0:
			play_shoot_animation()
			if col is EnemyWrapper:
				if current_weapon.weapon_name == "Gun":
					col.TakeDamage(gun_power)
				if current_weapon.weapon_name == "Machinegun":
					col.TakeDamage(machinegun_power)
				if current_weapon.weapon_name == "Shotgun":
					col.TakeDamage(shotgun_power)
		else:
			reload()
		
		if col is Buster:
			col.add_bust()
	

func add_amo(val: int):
	current_weapon.reserve_amo += val
	current_weapon.reserve_amo = min(current_weapon.reserve_amo, current_weapon.max_amo)
	INPUTMANAGER.update_amo.emit([current_weapon.current_amo, current_weapon.reserve_amo])
	

func play_shoot_animation():
	if !animation_player.is_playing():
		animation_player.play(current_weapon.shoot_animation)
		current_weapon.current_amo -= 1
		INPUTMANAGER.update_amo.emit([current_weapon.current_amo, current_weapon.reserve_amo])
