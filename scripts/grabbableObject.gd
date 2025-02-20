extends RigidBody3D

class_name Grabbable

var enabled := true

var grabParent : Node3D
@export var rigidBodyToGrab : RigidBody3D

var isGrabbed : bool = false :
	set(value):
		isGrabbed = value
		#if(value):
			#axis_lock_angular_x = true
			#axis_lock_angular_y = true
			#axis_lock_angular_z = true
			#
		#else:
			#
			#axis_lock_angular_x = false
			#axis_lock_angular_y = false
			#axis_lock_angular_z = false
			
func grabBehavior():
	set_freeze_enabled(true)
	self.reparent(grabParent)
	isGrabbed = true
	gravity_scale = 0.0

func ungrabBehavior():
	set_freeze_enabled(false)
	reparent(owner)
	gravity_scale = 1.0
