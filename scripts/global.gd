extends Node


func _physics_process(delta: float) -> void:
	
	if(Input.is_action_just_released("quit")):
		
		get_tree().quit()
		
