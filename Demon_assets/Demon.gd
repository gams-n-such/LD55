extends CharacterBody3D
class_name Demon

# TODO implement fractions and abilities
enum Fraction {none}
enum Abilities {none}

# Demon stats
var LEVEL := 1.0
var POWER := randf_range(10.0, 50.0)
var HEALTH := randf_range(100.0, 500.0)
var SACRIFICE_VALUE := randi_range(0, 100)
var NAME := "name " + str(randi_range(0, 2048))
var FRACTION := Fraction.none
var ABILITIES := [Abilities.none]

# Demon requirements
var LEGION_POWER := 0.0
var SACRIFICES := 0
var DESIRABLE_FRACTIONS := [Fraction.none]
var UNDESIREABLE_FRACTIONS := [Fraction.none]

# Global variables
@export var SPEED := 15.0
@export var GRAVITY := ProjectSettings.get_setting("physics/3d/default_gravity") as float
@export var is_active := false

func _physics_process(delta):
	# movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	placeholder_animation(delta)
	
	if is_active:
		move_in_direction(input_dir, delta)

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

