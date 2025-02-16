extends Node3D

@export var armature : Node3D

@export var camera : Camera3D

@export var animationPlayer : AnimationPlayer

var handIsOpen := true

func _physics_process(delta: float) -> void:
	
	if(Input.is_action_just_released("Click")):
		toggleHandOpen()
		
	
	rayCastAtPlane()
	
func rayCastAtPlane():
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 300
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result := space.intersect_ray(ray_query)
	if(raycast_result):
		armature.position = Vector3(raycast_result.position.x,clamp(raycast_result.position.y, 0, camera.position.y + (camera.position.y / 3)),raycast_result.position.z - 3)

func toggleHandOpen():
	
	if(!handIsOpen):
		animationPlayer.play("open_hand")
		handIsOpen = true
	else:
		animationPlayer.play_backwards("open_hand")
		handIsOpen = false
		
