@tool
extends StaticBody3D

var box_shape : BoxShape3D:
	get:
		return %Shape.get_shape() as BoxShape3D

var box_mesh : BoxMesh:
	get:
		return %Mesh.get_mesh() as BoxMesh

var box_material : StandardMaterial3D:
	get:
		return box_mesh.material as StandardMaterial3D

@export var box_size : Vector3 = Vector3(1, 1, 1):
	get:
		return box_shape.get_size()
	set(value):
		if Engine.is_editor_hint():
			box_shape.size = value
			box_mesh.size = value

@export var box_color : Color = Color.DIM_GRAY:
	get:
		return box_material.albedo_color
	set(value):
		if Engine.is_editor_hint():
			box_material.albedo_color = value

func _ready():
	pass # Replace with function body.
