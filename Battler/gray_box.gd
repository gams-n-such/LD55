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
	get: #TODO Why 'get' do not work in runtime (only editor)
		return box_size#box_shape.get_size()
	set(value):
		if Engine.is_editor_hint():
			box_shape.size = value
			box_mesh.size = value
			private_box_size=value
			box_size=value

@export var box_color : Color = Color.DIM_GRAY:
	get:
		return box_color#box_material.albedo_color
	set(value):
		if Engine.is_editor_hint():
			box_material.albedo_color = value
			private_box_color=value
			box_color=value

@export_category("private")
@export var private_box_size : Vector3
@export var private_box_color : Color 

func _ready():
	%Mesh.get_mesh().material.albedo_color = private_box_color
	%Mesh.mesh.size = private_box_size
	%Shape.shape.size = private_box_size
	print(private_box_size)
	print(box_size)
