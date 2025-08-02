extends Node

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gen_demons_from_pool(pool : DemonPool, count : int) -> Array[DemonInstance]:
	var pool_entries = pool.get_random_entries(count)
	var result : Array[DemonInstance] = []
	
	return result

func gen_demon_of_type(type : DemonType) -> DemonInstance:
	
	return null
