extends Node
class_name Game

const MOVESPEED: int = 3.0

@export var first_path : PathFollow3D
@export var first_remote : RemoteTransform3D

var current_path : PathFollow3D:
	set (new_value):
		current_path = new_value
	get:
		return current_path

var current_remote : RemoteTransform3D:
	set (new_value):
		current_remote = new_value
		SetCurrentRemote(current_remote)
	get:
		return current_remote

func _ready():
	GAMEMANAGER.game = self
	current_path = first_path
	current_remote = first_remote

func _physics_process(delta):
	FollowCurrentPath(current_path, delta)


func SetCurrentRemote(new_remote: RemoteTransform3D):
	new_remote.remote_path = GAMEMANAGER.player.get_path()

func FollowCurrentPath(new_path: PathFollow3D, delta : float):
	new_path.progress += MOVESPEED * delta
