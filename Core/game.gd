extends Node

@onready var menu_scene : PackedScene = load("res://Menu/main_menu.tscn")
@onready var how_to_play_scene : PackedScene = load("res://Menu/HowToPlay/HowToPlay.tscn")
@onready var sandbox_scene : PackedScene = load("res://Levels/sandbox.tscn")


@onready var tutorial_scene : PackedScene = load("res://Battler/battle_arena.tscn")
@onready var tinder_scene : PackedScene = load("res://Tinder/tinder_scene.tscn")
@onready var arena_scene : PackedScene = load("res://Battler/battle_arena.tscn")

var current_level : GameLevel

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func start_new_game(with_tutorial : bool):
	PlayerState.reset()
	if with_tutorial:
		# TODO
		get_tree().change_scene_to_packed(tinder_scene)
	else:
		get_tree().change_scene_to_packed(tinder_scene)

func switch_to_menu_level():
	get_tree().change_scene_to_packed(menu_scene)

func load_battle_arena_for_level(level : GameLevel):
	get_tree().change_scene_to_packed(menu_scene)
	get_tree().get_current_scene()


func switch_to_how_to_play_level():
	get_tree().change_scene_to_packed(how_to_play_scene)

func switch_to_sandbox_level():
	get_tree().change_scene_to_packed(sandbox_scene)

