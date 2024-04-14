extends Node3D

class_name Person

var MaxHealth := randf_range(100.0, 500.0)
var Health=MaxHealth

func _physics_process(delta):
	$hpBar.hp=Health
	$hpBar.max_hp=MaxHealth


func damage(hit):
	Health-=50
	if Health<=0:
		self.queue_free()
