extends Node
class_name Demons3D
var id=0

func show(n:Node):
	assert(id<get_child_count())
	n.reparent(get_child(id),false)
	get_child(id).acctive=true
	get_child(id).visible=true
	id+=1
