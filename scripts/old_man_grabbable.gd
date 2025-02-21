extends Grabbable

class_name GrabbableOldMan

@export var oldManContainer : Node3D

func grabbableBehavior():
	#oldManContainer.unpinJoints()
	set_freeze_enabled(true)
	self.reparent(grabParent)
	isGrabbed = true
	gravity_scale = 0.0
	
func ungrabBehavior():
	#oldManContainer.pinJoints()
	set_freeze_enabled(false)
	reparent(owner)
	gravity_scale = 1.0
	
