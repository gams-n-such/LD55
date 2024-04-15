extends Node

@onready var menu_scene : PackedScene = load("res://Menu/main_menu.tscn")
@onready var how_to_play_scene : PackedScene = load("res://Menu/HowToPlay/HowToPlay.tscn")
@onready var sandbox_scene : PackedScene = load("res://Levels/sandbox.tscn")


@onready var tutorial_scene : PackedScene = load("res://Battler/battle_arena.tscn")
@onready var tinder_scene : PackedScene = load("res://Tinder/tinder_scene.tscn")
@onready var arena_scene : PackedScene = load("res://Battler/battle_arena.tscn")

var current_level : GameLevel
var current_campaign : Campaign = preload("res://Levels/main_campaign.tres")

func _ready():
	pass

func start_new_game(with_tutorial : bool):
	PlayerState.reset()
	if with_tutorial:
		# TODO
		get_tree().change_scene_to_packed(tinder_scene)
	else:
		start_campaign()

func start_campaign():
	assert(not current_campaign.levels.is_empty())
	start_level(0)

func move_to_previous_level():
	var cur_level_idx = current_campaign.levels.find(current_level)
	var prev_level_idx = cur_level_idx - 1
	start_level(prev_level_idx)

func move_to_next_level():
	var cur_level_idx = current_campaign.levels.find(current_level)
	var next_level_idx = cur_level_idx + 1
	start_level(next_level_idx)

func start_level(level_idx : int):
	if level_idx >= current_campaign.levels.size():
		win_game()
		return
	if level_idx < 0:
		level_idx = 0
	current_level = current_campaign.levels[level_idx]
	get_tree().change_scene_to_packed(tinder_scene)

func win_game():
	pass # TODO

func switch_to_menu_level():
	get_tree().change_scene_to_packed(menu_scene)

func load_battle_arena_for_level(level : GameLevel):
	get_tree().change_scene_to_packed(menu_scene)
	get_tree().get_current_scene()


func switch_to_how_to_play_level():
	get_tree().change_scene_to_packed(how_to_play_scene)

func switch_to_sandbox_level():
	get_tree().change_scene_to_packed(sandbox_scene)

