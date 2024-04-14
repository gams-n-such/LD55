extends MeshInstance3D

var id=0
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	id+=1
	print(id,"RRRRRRRRRRRRRRR")
	if id==1:
		#var n=find_parent("Demon_card").demon.Name
		#print("read:"+n)
		var m:Mesh=self.mesh.duplicate()
		var mat:BaseMaterial3D=StandardMaterial3D.new()#m.surface_get_material(0).duplicate(true)
		#mat.albedo_texture
		var data= PackedByteArray()
		data.resize(256*3)
		data.fill(0)
		randomize()
		#head
		data[248*3+0]=randi()%256
		data[248*3+1]=randi()%256
		data[248*3+2]=randi()%256
		print(data[248*3+0])
		#body
		data[250*3+0]=randi()%256
		data[250*3+1]=randi()%256
		data[250*3+2]=randi()%256
		
		#eye
		data[249*3+0]=255
		data[249*3+1]=255
		data[249*3+2]=255
		
		#for i in 256*3:
		#	data[i]=randi()%256
		#print(data)
		var i=Image.create_from_data(256,1,false,Image.FORMAT_RGB8,data)
		#i.save_jpg("test.jpg")
		var t:ImageTexture=ImageTexture.create_from_image(i)
		mat.albedo_texture=t
		#m.surface_set_material(0,mat)
		self.material_override=mat

