class_name GameLevel extends Resource

@export_category("Level")
@export var location_name : String = "Some Town"
@export var demon_count : int = 5
@export var demon_pool : DemonPool
@export var enemies : Array[EnemyGroup] = []

