extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var level:GameLevel=Game.current_level
	var el:Array[EnemyDefinition]=level.list_enemies()
	for id in get_child_count():
		var p:Person=get_child(id)
		if id>el.size():
			p.queue_free()



