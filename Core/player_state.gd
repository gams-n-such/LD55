class_name PlayerState extends Node

@export var player_name : String = ""
@export var player_legion : Legion = Legion.new()
@export var player_liked : Array[DemonInstance] = []

var legion : Node:
	get:
		return %Legion

var demons : Array[DemonInstance]:
	get:
		var result: Array[DemonInstance]
		result.assign(legion.get_children())
		return result

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass

func reset():
	
	pass

func add_demon(demon : DemonInstance):
	player_liked.append(demon)

func remove_demon(demon : DemonInstance):
	player_liked.erase(demon)
