extends Node3D

@export var jointContainer : Node3D


func unpinJoints():
	for i in jointContainer.get_children():
		i.enabled = false

func pinJoints():
	for i in jointContainer.get_children():
		i.enabled = true
