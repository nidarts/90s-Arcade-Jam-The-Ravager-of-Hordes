extends Node

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event):
	if event.is_action_pressed("Exit"):
		INPUTMANAGER.exit()

func exit():
	get_tree().quit()
