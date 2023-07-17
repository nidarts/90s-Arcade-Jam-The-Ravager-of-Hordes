extends Node
class_name Game

const MOVESPEED: int = 1.0

@export var pathes : Array[PathFollow3D]
@export var pathes_remote : Array[RemoteTransform3D]

var current_path := 0

func _ready():
	GAMEMANAGER.game = self
	pathes_remote[current_path].remote_path = GAMEMANAGER.player.get_path()

func _physics_process(delta):
	pathes[current_path].progress += MOVESPEED * delta


func _input(event):
	if event.is_action_pressed("Jump"):
		if current_path >= pathes.size()-1:
			current_path = 0
		else :
			current_path += 1
		pathes_remote[current_path].remote_path = GAMEMANAGER.player.get_path()
	
