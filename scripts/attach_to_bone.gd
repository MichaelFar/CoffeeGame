extends Node3D

@export var skeleton : Skeleton3D

@export var bone : String

@export var keepAngle : bool

var body_pos
var body
func _ready() -> void:
	
	body = skeleton.find_bone(bone)
	body_pos = skeleton.get_bone_pose_position(body)
	# Make any changes on the pos and update the bone

func _physics_process(delta: float) -> void:
	if(keepAngle):
		global_transform.basis = (skeleton.global_transform * skeleton.get_bone_global_pose(body)).basis
		
	#position = body_pos
