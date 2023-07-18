extends Camera3D
class_name PlayerCamera

func _ready():
	GAMEMANAGER.camera = self
