extends Node3D

@export var objectToFollow : Node3D

func _physics_process(delta: float) -> void:
	global_position = objectToFollow.global_position
