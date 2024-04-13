@tool
extends Control

func _process(delta):
	var b1:Control=$decline
	var b2:Control=$accept
	#print(self.size)
	self.size.y=self.size.x*0.5
	self.position.y=get_parent().size.y-self.size.y
	b1.position=Vector2(0,0)*self.size.x*0.5
	b1.size=Vector2(1,1)*self.size.x*0.5
	b2.position=Vector2(1,0)*self.size.x*0.5
	b2.size=Vector2(1,1)*self.size.x*0.5

