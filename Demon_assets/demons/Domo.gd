extends MeshInstance3D

@export var look:DemonLookResource
var was_inited=false
@export var is_main=false
# Called when the node enters the scene tree for the first time.


	#if look==null:
	#	match  randi()%2:
	#		0:look=load("res://Demon_assets/DemonLook/t1.tres")
	#		1:look=load("res://Demon_assets/DemonLook/t2.tres")


func _ready():
	print("READY LOOK?",look!=null)
	if is_main:
		match  randi()%2:
			0:look=load("res://Demon_assets/DemonLook/t1.tres")
			1:look=load("res://Demon_assets/DemonLook/t2.tres")
		$head/Domo3.look=self.look
		$head/Domo2.look=self.look
		wake()
		$head/Domo2.wake()
		$head/Domo3.wake()

func wake():
	if not was_inited:
		was_inited=true
		if look==null:
			print("MAKETRUE")
			look=DemonLookResource.new()
			look.biome=DemonLookResource.Biome.TOKSIC
			randomize()
			#look.small_feature_seed=randi()
		assert(look!=null)
		var pallete=look.get_colors(self.get_instance_id())
		if $head!=null:
			$head.select({
				DemonLookResource.HeadType.SMALL_EARS:0,
				DemonLookResource.HeadType.BIG_EARS:1
				}[look.head])
		#var m:Mesh=self.mesh.duplicate()
		var mat:BaseMaterial3D=StandardMaterial3D.new()#m.surface_get_material(0).duplicate(true)
		#mat.albedo_texture
		var data= PackedByteArray()
		data.resize(256*3)
		data.fill(0)
		randomize()
		
		var memory_laout={
			250:DemonLookResource.ColorPallete.BODY,
			248:DemonLookResource.ColorPallete.HEAD,
			249:DemonLookResource.ColorPallete.EYE,
			251:DemonLookResource.ColorPallete.LINES
		}
		
		for offset in memory_laout.keys():
			var body_part= memory_laout[offset]
			var body_color:Color=pallete[body_part]
			data[3*offset+0]=body_color.r8
			data[3*offset+1]=body_color.g8
			data[3*offset+2]=body_color.b8
		
		var i=Image.create_from_data(256,1,false,Image.FORMAT_RGB8,data)
		var t:ImageTexture=ImageTexture.create_from_image(i)
		mat.albedo_texture=t
		#m.surface_set_material(0,mat)
		self.material_override=mat

