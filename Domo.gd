extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var m:Mesh=self.mesh
	var mat:BaseMaterial3D=m.surface_get_material(0)
	#mat.albedo_texture
	var data= PackedByteArray()
	data.resize(256*3)
	data.fill(0)
	randomize()
	data[251*3+0]=randi()%256
	data[251*3+1]=randi()%256
	data[251*3+2]=randi()%256
	for i in 256*3:
		data[i]=randi()%256
	print(data)
	var i=Image.create_from_data(256,1,false,Image.FORMAT_RGB8,data)
	i.save_jpg("test.jpg")
	var t:ImageTexture=ImageTexture.create_from_image(i)
	mat.albedo_texture=t
	m.surface_set_material(0,mat)

