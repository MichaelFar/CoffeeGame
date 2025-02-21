extends Grabbable

@export var pourPoint : Marker3D

@export var waterParticle : GPUParticles3D

func _physics_process(delta: float) -> void:
	
	waterParticle.emitting = pourPoint.global_position.y < global_position.y
	
