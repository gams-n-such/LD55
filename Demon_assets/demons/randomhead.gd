extends Node

func _ready():
	select(randi()%get_child_count())

func select(i):
	for c in get_children():
		#var mi:MeshInstance3D=c
		c.visible=false
	get_child(i).visible=true
