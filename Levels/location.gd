extends Node

@export var levels:Array[GameLevel]
# Called when the node enters the scene tree for the first time.
@export var locations:Array[PackedScene]
func _ready():
	randomize()
	var l:GameLevel=levels[randi()%levels.size()]
	Game.current_level=l
	start_level(l)
	
func start_level(l):
	var ok=false
	for id in range(locations.size()):
		var resource_file_name=locations[id].resource_path.split("/")[-1].split(".")[0]
		if l.location_name==resource_file_name:
			add_child(locations[id].instantiate())
			ok=true
			break
	if not ok:
		assert(false,"ERROR missing location")
