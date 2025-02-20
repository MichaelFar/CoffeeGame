extends Node3D

@export var camera : Camera3D

@export var animationPlayer : AnimationPlayer

@export var collider : CollisionShape3D

@export var grabAreaShape : CollisionShape3D

var handIsClosed := true

var handInGrabbable := false

var grabbedObject : Grabbable

var inGrabTimeWindow : bool = false :
	
	set(value):
		
		if(handInGrabbable && handIsClosed && grabbableObject != null):
			
			print("Grabbing Object")
			grabbedObject = grabbableObject
			grabbedObject.grabParent = grabAreaShape
			grabbedObject.grabBehavior()
			collider.disabled = true
			
		else:
			
			if(grabbedObject != null):
				
				grabbedObject.ungrabBehavior()
				
			grabbedObject = null
			

var grabbableObject

func _physics_process(delta: float) -> void:
	
	if(Input.is_action_just_released("Click")):
		
		toggleHandOpen()
		print("Hand global position is " + str(global_position))
		print("Camera position is " + str(camera.global_position))
	
	rayCastAtPlane()
			
func rayCastAtPlane():
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 500
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	
	var raycast_result := space.intersect_ray(ray_query)
	
	if(raycast_result):
		
		global_position = raycast_result.position#Vector3(raycast_result.position.x,clamp(raycast_result.position.y, 0, camera.position.y + (camera.position.y / 3)),raycast_result.position.z - 3)

func toggleHandOpen():
	if(visible):
		if(!handIsClosed):
			
			animationPlayer.play("open_hand")
			handIsClosed = true
			
			if(handInGrabbable):
				
				inGrabTimeWindow = true
			
		else:
			
			animationPlayer.play_backwards("open_hand")
			handIsClosed = false
			
			if(handInGrabbable):
				
				inGrabTimeWindow = false
				
			if(grabbableObject != null):
				
				grabbableObject.set_freeze_enabled(false)
				grabbableObject.reparent(owner.owner)
				grabbableObject.gravity_scale = 1.0
				
			collider.disabled = false
			
func toggleCollision():
	if(collider.disabled == grabAreaShape.disabled):
		collider.disabled = !collider.disabled
	grabAreaShape.disabled = !grabAreaShape.disabled
	
func _on_grab_area_area_entered(area: Area3D) -> void:
	
	if(area.owner is Grabbable):
		
		grabbableObject = area.owner
		
		if(grabbableObject.enabled):
		
			handInGrabbable = true
		
func _on_grab_area_area_exited(area: Area3D) -> void:
	
	if(area.owner is Grabbable):
	
		if(grabbedObject != null):
	
			return
	
		handInGrabbable = false
		
		grabbableObject = null
