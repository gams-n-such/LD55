class_name BattlerUnit extends CharacterBody3D

var _unit_def : UnitDefinition
@export var unit_definition : UnitDefinition:
	get:
		return _unit_def
	set(value):
		set_definition(value)

# Attributes

var health : Attribute:
	get:
		return %Health

var damage : Attribute:
	get:
		return %Power

var move_speed = 5.0
var attack_speed : float:
	get:
		return 1.0 / (%AttackTimer as Timer).wait_time
@export var SPEED = 5.0



# AI

signal target_changed(unit : BattlerUnit, new_target : BattlerUnit)

@export var allies_group : String = "Demons"
@export var enemies_group : String = "Humans"

func get_enemy_units() -> Array[BattlerUnit]:
	var enemy_nodes = get_tree().get_nodes_in_group(enemies_group)
	var result : Array[BattlerUnit] = []
	for enemy in enemy_nodes:
		var enemy_unit = enemy as BattlerUnit
		if enemy_unit:
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

func find_new_target():
	target = get_random_enemy()

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
var home_pos : Vector3
var attack = true
var acctive = false

# Global variables
@export var IS_ACTIVE := false

func _init():
	%HealthBar.attribute = health
	pass

func _on_ready():
	assert(unit_definition)
	add_to_group(allies_group)

func set_definition(unit_def : UnitDefinition):
	unit_definition = unit_def
	health.max_value = unit_definition.health
	health.base_value = health.max_value
	damage.base_value = unit_definition.power
	(%AttackTimer as Timer).wait_time = 1.0 / unit_definition.attack_speed
	pass

#func _physics_process(delta):
#	# movement
#	var input_dir = Input.get_vector("left", "right", "forward", "backward")
#	
#	placeholder_animation(delta)
#	
#	if IS_ACTIVE:
#		move_in_direction(input_dir, delta)

func move_in_direction(input_dir : Vector2, delta : float):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

var placeholder_animation_value := 0.0
func placeholder_animation(delta):
	placeholder_animation_value += delta
	$MeshInstance3D.scale = Vector3(1.0, (1 + cos(placeholder_animation_value) / 10.0), 1.0)

func upadate_taget():
	print($"..")
	print($"../../Enemies")
	if $"../../Enemies".get_child_count()>0:
		target=$"../../Enemies".get_child(randi()%$"../../Enemies".get_child_count())
	else:
		get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
		target=null

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	#set_movement_target(NavigationServer3D.map_get_closest_point_to_segment(
	#		get_world_3d().navigation_map,
	#		$"../goal".global_position,
	#		$"../goal".global_position+Vector3.DOWN*100.0
	#		))
	upadate_taget()
	var nav_point = NavigationServer3D.map_get_closest_point_to_segment(
			get_world_3d().navigation_map,
			target.global_position,
			target.global_position + Vector3.DOWN * 100.0
			)
	set_movement_target(target.global_position)
	home_pos = global_position

	print("SET", nav_point)


func _physics_process(delta):
	if acctive:
		# movement
		var input_dir = Vector2.ZERO
		if Input.is_key_pressed(KEY_UP):
			input_dir+=Vector2.UP
		if Input.is_key_pressed(KEY_DOWN):
			input_dir+=Vector2.DOWN
		$NavigationAgent3D.path_desired_distance = 0.5
		$NavigationAgent3D.target_desired_distance = 0.5
		if $NavigationAgent3D.is_navigation_finished():
			if attack==true:
				attack=false
				set_movement_target(home_pos)
				if is_instance_valid(target):
					target.take_damage(damage)
			else:
				attack=true
				upadate_taget()
				if target != null:
					set_movement_target(target.global_position)
			return
		
		#set_movement_target($"../goal".global_position)
		
		var current_agent_position: Vector3 = global_position
		var next_path_position: Vector3 = $NavigationAgent3D.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * 10.0
		#move_in_direction(Vector2(velocity.x,velocity.z), delta)
		self.global_position=global_position+velocity*delta*SPEED

func set_movement_target(movement_target: Vector3):
	$NavigationAgent3D.set_target_position(movement_target)

func set_target(new_target):
	($NavigationAgent3D as NavigationAgent3D).target

func take_damage(dmg): 
	health.base_value -= dmg

func _on_health_value_changed(attribute: Attribute, new_value: float) -> void:
	if new_value <= 0:
		queue_free()
