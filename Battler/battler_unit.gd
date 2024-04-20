class_name BattlerUnit extends CharacterBody3D

#region Unit

var _unit_def : UnitDefinition
@export var unit_definition : UnitDefinition:
	get:
		return _unit_def
	set(value):
		set_definition(value)

func set_definition(unit_def : UnitDefinition):
	unit_definition = unit_def
	health_attribute.max_value = unit_definition.health
	health_attribute.base_value = health_attribute.max_value
	power_attribute.base_value = unit_definition.power
	speed_attribute.base_value = unit_definition.speed
	attack_range_attribute.base_value = unit_definition.range

#endregion

#region Attributes

var health_attribute : Attribute:
	get:
		return %Health

var health : float:
	get:
		return health_attribute.value

var max_health : float:
	get:
		return health_attribute.max_value

func take_damage(dmg : float) -> void: 
	health_attribute.base_value -= dmg

func _on_health_value_changed(attribute: Attribute, new_value: float) -> void:
	if new_value <= 0:
		queue_free()

var alive : bool:
	get:
		return health > 0

var power_attribute : Attribute:
	get:
		return %Power

var attack_damage : float:
	get:
		return power_attribute.value

var attack_range_attribute : Attribute:
	get:
		return %AttackRange

var attack_range : float:
	get:
		return attack_range_attribute.value

var speed_attribute : Attribute:
	get:
		return %Speed

var attack_speed : float:
	get:
		return speed_attribute.value

var move_speed_attribute : Attribute:
	get:
		return %MoveSpeed

var move_speed : float:
	get:
		return move_speed_attribute.value

var _move_speed_mod : AttributeMod = null

func _on_speed_value_changed(attribute: Attribute, new_value: float):
	(%AttackTimer as Timer).wait_time = 1.0 / new_value
	if _move_speed_mod:
		move_speed_attribute.remove_modifier(_move_speed_mod)
	var new_move_speed_mod_info : AttributeModInfo = AttributeModInfo.new()
	new_move_speed_mod_info.mod_type = AttributeModInfo.ModType.ADD_PERCENT
	new_move_speed_mod_info.mod_value = speed_attribute.value - 1.0
	_move_speed_mod = move_speed_attribute.add_modifier(new_move_speed_mod_info)

#endregion

#region AI

signal target_changed(unit : BattlerUnit, new_target : BattlerUnit)

@export var allies_group : String = "Demons"
@export var enemies_group : String = "Humans"

func get_enemy_units() -> Array[BattlerUnit]:
	var enemy_nodes = get_tree().get_nodes_in_group(enemies_group)
	var result : Array[BattlerUnit] = []
	for enemy in enemy_nodes:
		var enemy_unit = enemy as BattlerUnit
		if is_instance_valid(enemy_unit):
			result.append(enemy_unit)
	return result

func get_random_enemy() -> BattlerUnit:
	return get_enemy_units().pick_random()

var _target : BattlerUnit = null
var target : BattlerUnit:
	get:
		return _target
	set(value):
		if target == value:
			return
		_target = value
		target_changed.emit(self, _target)

func has_valid_target() -> bool:
	return is_instance_valid(target)

func find_new_target():
	target = get_random_enemy()

#endregion

#region Attacking

func has_target_in_range() -> bool:
	if not has_valid_target():
		return false
	else:
		return global_position.distance_to(target.global_position) < attack_range

func is_attacking() -> bool:
	return not (%AttackTimer as Timer).is_stopped()

func start_attacking():
	if is_attacking():
		return
	(%AttackTimer as Timer).start()

func stop_attacking(immediately : bool = true):
	if not is_attacking:
		return
	(%AttackTimer as Timer).stop()

func _on_attack_timer_timeout():
	deal_damage(target)

func deal_damage(target_unit : BattlerUnit):
	if target_unit:
		target_unit.take_damage(attack_damage)

#endregion

#region Movement

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

var nav_agent : NavigationAgent3D:
	get:
		return %NavAgent

func update_nav_target():
	var current_desired_position = global_position
	if has_valid_target():
		current_desired_position = target.global_position
	set_nav_target(current_desired_position)

func set_nav_target(movement_target: Vector3):
	var nav_point = NavigationServer3D.map_get_closest_point(
			get_world_3d().navigation_map, movement_target)
	nav_agent.set_target_position(nav_point)

func tick_move_by_navigation(delta : float):
	if nav_agent.is_navigation_finished():
		return
	tick_move_towards(nav_agent.get_next_path_position(), delta)

func tick_move_towards(target_point : Vector3, delta : float):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	var distance_to_target : Vector3 = target_point - global_position
	var move_direction : Vector3 = distance_to_target.normalized()
	velocity.x = move_direction.x * move_speed * delta
	velocity.z = move_direction.z * move_speed * delta
	move_and_slide()

func get_dir_to_point(point : Vector3) -> Vector3:
	return (point - global_position).normalized()

func tick_move_with_input(input_dir : Vector2, delta : float):
	var world_direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	tick_move_in_direction(world_direction, delta)

func tick_move_in_direction(direction : Vector3, delta : float):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	var normalized_dir : Vector3 = direction.normalized()
	velocity.x = normalized_dir.x * move_speed * delta
	velocity.z = normalized_dir.z * move_speed * delta
	move_and_slide()

# Not sure if this is aplicable
func stop_movement():
	velocity = Vector3.ZERO

#endregion

func _init():
	%HealthBar.attribute = health
	pass

func _on_ready():
	assert(unit_definition)
	add_to_group(allies_group)

func _physics_process(delta : float):
	if not alive:
		return
	if not has_valid_target():
		find_new_target()
	if has_valid_target():
		update_nav_target()
		tick_move_by_navigation(delta)
		if has_target_in_range():
			start_attacking()
		else:
			stop_attacking()
	else:
		stop_movement()


func _on_attack_range_value_changed(attribute: Attribute, new_value: float):
	nav_agent.target_desired_distance = attack_range
