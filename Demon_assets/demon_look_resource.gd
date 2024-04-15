extends Resource
class_name DemonLookResource

enum HeadType{SMALL_EARS,BIG_EARS}
enum Biome{TOKSIC,FIRE,ICE,DARKNESS}

#public variables
@export var head:HeadType
@export var biome:Biome
#@export var small_feature_seed:int

#######################
#implemetation part
##########################

enum ColorPallete{HEAD,BODY,EYE,LINES}
var colors={}

func get_colors(rid:int):
	if not colors.has(rid):
		colors[rid]=_gen_colors()
	return colors[rid]

func _gen_colors():
	var res={}
	var rng=RandomNumberGenerator.new()
	rng.seed=randi()#small_feature_seed
	if biome==Biome.TOKSIC:
		print("tok")
		res[ColorPallete.HEAD]=Color.GREEN.lerp(Color.YELLOW,rng.randf())
		res[ColorPallete.BODY]=Color.DARK_GREEN.lerp(Color.OLIVE,rng.randf())
		res[ColorPallete.EYE]=Color.YELLOW.lerp(Color.WHITE,rng.randf())
		res[ColorPallete.LINES]=Color.DARK_GREEN.lerp(Color.BLACK,rng.randf())
	if biome==Biome.FIRE:
		print("FIRe")
		res[ColorPallete.HEAD]=Color.BLACK.lerp(Color.RED,rng.randf())
		res[ColorPallete.BODY]=Color.RED.lerp(Color.YELLOW,rng.randf())
		res[ColorPallete.EYE]=Color.YELLOW.lerp(Color.WHITE,rng.randf())
		res[ColorPallete.LINES]=Color.SADDLE_BROWN.lerp(Color.BLACK,rng.randf())
	if biome==Biome.ICE:
		res[ColorPallete.HEAD]=Color.BLUE.lerp(Color.GREEN_YELLOW,rng.randf())
		res[ColorPallete.BODY]=Color.DARK_GREEN.lerp(Color.OLIVE,rng.randf())
		res[ColorPallete.EYE]=Color.YELLOW.lerp(Color.WHITE,rng.randf())
		res[ColorPallete.LINES]=Color.DARK_GREEN.lerp(Color.BLACK,rng.randf())
	if biome==Biome.DARKNESS:
		res[ColorPallete.HEAD]=Color.BLUE.lerp(Color.GREEN_YELLOW,rng.randf())
		res[ColorPallete.BODY]=Color.DARK_GREEN.lerp(Color.OLIVE,rng.randf())
		res[ColorPallete.EYE]=Color.YELLOW.lerp(Color.WHITE,rng.randf())
		res[ColorPallete.LINES]=Color.DARK_GREEN.lerp(Color.BLACK,rng.randf())
	return res




