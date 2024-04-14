extends CharacterBody3D
class_name Demon

var MaxHealth := randf_range(100.0, 500.0)
var Health=MaxHealth
var Damage := randf_range(10.0, 50.0)
var Name := "name " + str(randi_range(0, 2048))

@export var SPEED = 25.0
var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
var home_pos:Vector3
var attack=true
var acctive=false
var target:Person

func upadate_taget():
	if $"../../Enemies".get_child_count()>0:
		target=$"../../Enemies".get_child(randi()%$"../../Enemies".get_child_count())
	else:
		get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
		target=null
func _ready():
	call_deferred("actor_setup")
	actor_setup()

func actor_setup():
	print("AS")
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	#set_movement_target(NavigationServer3D.map_get_closest_point_to_segment(
	#		get_world_3d().navigation_map,
	#		$"../goal".global_position,
	#		$"../goal".global_position+Vector3.DOWN*100.0
	#		))
	upadate_taget()
	set_movement_target(target.global_position)
	home_pos=global_position
			
	print("SET",NavigationServer3D.map_get_closest_point_to_segment(
			get_world_3d().navigation_map,
			target.global_position,
			target.global_position+Vector3.DOWN*100.0
			))


func _physics_process(delta):
	$hpBar.hp=Health
	$hpBar.max_hp=MaxHealth
	if acctive:
		# movement
		var input_dir = Vector2.ZERO#Input.get_vector("left", "right", "forward", "backward")
		if Input.is_key_pressed(KEY_UP):
			input_dir+=Vector2.UP
		if Input.is_key_pressed(KEY_DOWN):
			input_dir+=Vector2.DOWN
		#move_in_direction(input_dir, delta)
		#print($"../goal".global_position-global_position)
		$NavigationAgent3D.path_desired_distance = 0.5
		$NavigationAgent3D.target_desired_distance = 0.5
		if $NavigationAgent3D.is_navigation_finished():
			#if not $NavigationAgent3D.is_target_reachable():
				#print("???????")
			#print("END")
			if attack==true:
				attack=false
				set_movement_target(home_pos)
				if is_instance_valid(target):
					target.damage(50)
					self.damage(50)
			else:
				attack=true
				upadate_taget()
				set_movement_target(target.global_position)
			return
		
		#set_movement_target($"../goal".global_position)
		
		var current_agent_position: Vector3 = global_position
		var next_path_position: Vector3 = $NavigationAgent3D.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * 10.0
		#move_in_direction(Vector2(velocity.x,velocity.z), delta)
		self.global_position=global_position+velocity*delta
	
func set_movement_target(movement_target: Vector3):
	$NavigationAgent3D.set_target_position(movement_target)



func damage(v): 
	Health-=v
	if Health<=0:
		self.queue_free()

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
