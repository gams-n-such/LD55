extends Node

@onready var menu_scene : PackedScene = load("res://Menu/main_menu.tscn")
@onready var how_to_play_scene : PackedScene = load("res://Menu/HowToPlay/HowToPlay.tscn")
@onready var sandbox_scene : PackedScene = load("res://Levels/sandbox.tscn")

# TODO
@onready var tutorial_scene : PackedScene = load("res://Tinder/tinder_scene.tscn")
@onready var tinder_scene : PackedScene = load("res://Tinder/tinder_scene.tscn")
@onready var arena_scene : PackedScene = load("res://Battler/battle_arena.tscn")
# TODO
@onready var win_scene : PackedScene = load("res://Menu/main_menu.tscn")

@export var current_campaign : Campaign = preload("res://Levels/main_campaign.tres")
var current_level : GameLevel

var player_state : PlayerState:
	get:
		return %PlayerState

func _ready():
	pass

# Demons

func get_hired_demons() -> Array[DemonInstance]:
	var result : Array[DemonInstance]
	result.assign(%Legion.get_children())
	return result

func get_liked_demons() -> Array[DemonInstance]:
	var result : Array[DemonInstance]
	result.assign(%LikedDemons.get_children())
	return result

func like_demon(demon : DemonInstance) -> bool:
	if not demon:
		return false
	if %Legion.is_ancestor_of(demon):
		return false
	if %LikedDemons.is_ancestor_of(demon):
		return false
	demon.reparent(%LikedDemons)
	return true

func kill_demon(demon : DemonInstance) -> bool:
	if not demon:
		return false
	if !%Legion.is_ancestor_of(demon):
		assert(false)
		return false
	demon.queue_free()
	return true

func hire_demon(demon : DemonInstance, sacrifices : Array[DemonInstance]) -> bool:
	if not demon:
		return false
	if %Legion.is_ancestor_of(demon):
		return false
	if not %LikedDemons.is_ancestor_of(demon):
		assert(false)
		return false

	var required_sacrifices : int = demon.demon_type.required_sacrifices
	if required_sacrifices > 0:
		var offered_sacrifices : int = 0
		for victim in sacrifices:
			assert(%Legion.is_ancestor_of(demon))
			offered_sacrifices += victim.demon_type.sacrifice_value
		if offered_sacrifices < required_sacrifices:
			return false
		else:
			for victim in sacrifices:
				assert(kill_demon(victim))

	demon.reparent(%Legion)
	return true

# Game flow and changing scenes

func start_new_game(with_tutorial : bool):
	player_state.reset()
	if with_tutorial:
		get_tree().change_scene_to_packed(tutorial_scene)
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
	get_tree().change_scene_to_packed(win_scene)

func switch_to_menu_level():
	get_tree().change_scene_to_packed(menu_scene)

func load_battle_arena_for_level(level : GameLevel):
	get_tree().change_scene_to_packed(menu_scene)
	get_tree().get_current_scene()

func switch_to_how_to_play_level():
	get_tree().change_scene_to_packed(how_to_play_scene)

func switch_to_sandbox_level():
	get_tree().change_scene_to_packed(sandbox_scene)

