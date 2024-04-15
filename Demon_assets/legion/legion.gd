class_name Legion extends Node

@export var legion : Array[Demon] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func add_demon(demon : Demon):
	legion.append(demon)


func remove_demon(demon : Demon):
	var demon_index = legion.find(demon, 0)
	if demon_index > -1 :
		legion.remove_at(demon_index)
