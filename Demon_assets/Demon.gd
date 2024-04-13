extends CharacterBody3D
class_name Demon

var Health := randf_range(100.0, 500.0)
var Damage := randf_range(10.0, 50.0)
var Name := "name " + str(randi_range(0, 2048))

@export var SPEED = 15.0
var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
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
