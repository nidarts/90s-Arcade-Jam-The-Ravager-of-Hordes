extends StaticBody3D
class_name Buster

enum BusterType{
	HP,
	Amo
}

@onready var hp_buster = $"VisualContainer/HP-Buster"
@onready var amo_buster = $"VisualContainer/Amo-Buster"



@export var buster : BusterType
@export var hp_count : int
@export var amo_count : int


func _ready():
	amo_buster.visible = false
	hp_buster.visible = false
	
	if buster == BusterType.Amo:
		amo_buster.visible = true
	if buster == BusterType.HP:
		hp_buster.visible = true

func add_bust():
	if buster == BusterType.HP:
		GAMEMANAGER.player_add_health.emit(hp_count)
	
	if buster == BusterType.Amo:
		GAMEMANAGER.player_add_amo.emit(amo_count)
	
	GAMEMANAGER.player.pickup_bust.play()
	
	self.queue_free()
