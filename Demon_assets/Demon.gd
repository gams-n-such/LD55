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
	print($"..")
	print($"../../Enemies")
	if $"../../Enemies".get_child_count()>0:
		target=$"../../Enemies".get_child(randi()%$"../../Enemies".get_child_count())
	else:
		get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
		target=null
		
func _enter_tree():
	if get_node("../../Enemies")!=null:
		call_deferred("actor_setup")
	#actor_setup()

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

# TODO implement fractions and abilities
enum Fraction {none}
enum Abilities {none}

# Demon stats
var STATS := {
	"Level" : 1,
	"Power" : 1,
	"Health" : 1,
	"Sacrifice value" : 0, 
	"Fraction" : Fraction.none,
	"Abilities" : [Abilities.none]
}

# Demon requirements
var LEGION_POWER := 0.0
var SACRIFICES := 0
var DESIRABLE_FRACTIONS := [Fraction.none]
var UNDESIREABLE_FRACTIONS := [Fraction.none]

# Global variables
@export var NAME := "name " + str(randi_range(0, 2048))
#@export var SPEED := 15.0
#@export var GRAVITY := ProjectSettings.get_setting("physics/3d/default_gravity") as float
@export var IS_ACTIVE := false

func _init(level : int = 1, power : int = 1, health : int = 1, sacrifice_value : int = 1, fraction := Fraction.none, abilities := [Abilities.none]):
	STATS["Level"] = level
	STATS["Power"] = power
	STATS["Health"] = health
	STATS["Sacrifice value"] = sacrifice_value 
	STATS["Fraction"] = fraction
	STATS["Abilities"] = abilities

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

