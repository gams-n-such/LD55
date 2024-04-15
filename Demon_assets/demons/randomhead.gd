extends Node

func _ready():
	for c in get_children():
		#var mi:MeshInstance3D=c
		c.visible=false
	get_child(randi()%get_child_count()).visible=true
