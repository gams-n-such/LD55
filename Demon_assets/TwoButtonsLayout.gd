@tool
extends Control

func _process(delta):
	var b1:Control=$decline
	var b2:Control=$accept
	#print(self.size)
	self.size.y=min(self.size.x*0.5,get_parent().size.y*0.25)
	self.position.y=get_parent().size.y-self.size.y
	b1.position=Vector2(0,0)*size.y
	b1.size=Vector2(1,1)*size.y
	b2.position=Vector2(1,0)*(size.x-size.y)
	b2.size=Vector2(1,1)*size.y

