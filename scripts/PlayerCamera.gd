extends Camera3D

var camera := self
var mouse_position: Vector2
var ray_length : int = 1000


func  _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		ScreenPointToRay()

func ScreenPointToRay():
	var space_state = get_world_3d().direct_space_state
	mouse_position = get_viewport().get_mouse_position()	
	var raycast_origin = camera.project_ray_origin(mouse_position)
	var raycast_target = raycast_origin + camera.project_ray_normal(mouse_position) * ray_length
	var physics_raycast_query = PhysicsRayQueryParameters3D.create(raycast_origin, raycast_target)
	var raycast_result = space_state.intersect_ray(physics_raycast_query)
	
	if raycast_result.is_empty():
		print("")
	else:
		var col = raycast_result.collider
		col.say_comething()
			
	
