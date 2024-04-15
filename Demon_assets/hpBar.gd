extends MeshInstance3D

var hp=5.0
var max_hp=10.0

func _process(delta):
	var value=float(hp)/float(max_hp)
	$green.position.x=-(1-value)*0.5
	$green.scale.x=value*1.01
	if value<0:
		visible=false
	
