extends StaticBody3D
class_name Box


func say_comething():
	GAMEMANAGER.TargetKill()
	GAMEMANAGER.AddPoint(100)
	queue_free()
