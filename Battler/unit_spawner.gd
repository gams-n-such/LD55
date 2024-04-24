# To update shape in editor
@tool
extends Node3D

signal unit_spawned(unit)

var area_shape : BoxShape3D:
	get:
		return (%BoxShape as CollisionShape3D).shape as BoxShape3D

@export var unit_scene : PackedScene
@export var area_extent : Vector3:
	get:
		return area_shape.get_size()
	set(value):
		if Engine.is_editor_hint():
			area_shape.set_size(value)

func _ready():
	area_shape.set_size(area_extent)
	pass

func spawn_unit_from_definition(enemy_definition : UnitDefinition):
	var unit = unit_scene.instantiate()
	#get_tree().get_root().add_child(unit)
	get_parent().add_child(unit)
	unit.global_position = get_random_spawn_position()
	unit.global_rotation = global_rotation
	unit_spawned.emit(unit)

func get_random_spawn_position() -> Vector3:
	var result : Vector3 = Vector3()
	var half_box = area_extent / 2
	print(half_box)
	result.x = global_position.x + randf_range(-half_box.x, half_box.x)
	result.z = global_position.z + randf_range(-half_box.z, half_box.z)
	result.y = global_position.y + half_box.y
	return result
