class_name BattleArena extends Node3D

@export var selected_level : GameLevel

var spawned_enemies : Array[Node] = []
var spawned_demons : Array[Node] = []

func _ready():
	init_from_level(selected_level)
	%Camera.current = true
	pass

func init_from_level(level : GameLevel):
	spawn_enemies_for_level(level)
	spawn_demons_for_level(level)
	pass

func spawn_enemies_for_level(level : GameLevel):
	for enemy_group in level.enemies:
		for enemy_index in enemy_group.enemy_count:
			print("Spawn enemy...")
			%EnemySpawner.spawn_unit_from_definition(enemy_group.enemy)
	pass

func spawn_demons_for_level(level : GameLevel):
	for enemy_group in level.enemies:
		for enemy_index in enemy_group.enemy_count:
			print("Spawn demons...")
			%DemonSpawner.spawn_unit_from_definition(enemy_group.enemy)
	pass


func _on_demon_unit_spawned(unit):
	spawned_demons.append(unit)
	unit.defeated.connect(_on_demon_killed)

func _on_demon_killed(demon):
	spawned_demons.erase(demon)
	if spawned_demons.is_empty():
		handle_player_loss()
		pass


func _on_enemy_unit_spawned(unit):
	spawned_enemies.append(unit)
	unit.defeated.connect(_on_enemy_killed)

func _on_enemy_killed(enemy):
	spawned_enemies.erase(enemy)
	if spawned_enemies.is_empty():
		handle_player_victory()
		pass


func handle_player_victory():
	pass

func handle_player_loss():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("$$$$$$$$$$4")
		get_tree().root.print_tree()
		
