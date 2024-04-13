extends Node

@onready var menu_scene : PackedScene = load("res://Menu/main_menu.tscn")
@onready var how_to_play_scene : PackedScene = load("res://Menu/HowToPlay/HowToPlay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func switch_to_menu_level():
	get_tree().change_scene_to_packed(menu_scene)


func switch_to_how_to_play_level():
	get_tree().change_scene_to_packed(how_to_play_scene)
