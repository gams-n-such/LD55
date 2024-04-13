class_name PlayerState extends Node

@export var player_name : String = ""
@export var player_legion : Array[Demon] = []
@export var player_liked : Array[DemonRecruitingState] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_demon(demon : Demon):
	player_legion.append(demon)


func remove_demon(demon : Demon):
	var demon_index = player_legion.find(demon, 0)
	if demon_index > -1 :
		player_legion.remove_at(demon_index)


func add_demon_recruiting_state(demon_recruiting_state : DemonRecruitingState):
	player_liked.append(demon_recruiting_state)


func remove_demon_recruiting_state(demon_recruiting_state : DemonRecruitingState):
	var index = player_liked.find(demon_recruiting_state, 0)
	if index > -1 :
		player_liked.remove_at(index)
