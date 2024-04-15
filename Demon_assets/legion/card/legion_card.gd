extends Control

class_name LegionCard

@export var displayed_demon : Demon

signal deleted(from : LegionCard)

@onready var demon_sub_viewport : SubViewport = $Background/V/DemonSubViewportContainer/DemonSubViewport
@onready var demon_camera3d : Camera3D = $Background/V/DemonSubViewportContainer/DemonSubViewport/DemonCamera3D
@onready var name_label : Label = $Background/V/M/DemonStatsContainer/DemonDescriptionContainer/Name
@onready var hp_label : Label = $Background/V/M/DemonStatsContainer/HPAndPowerContainer/HP
@onready var power_label : Label = $Background/V/M/DemonStatsContainer/HPAndPowerContainer/Power
@onready var faction_label : Label = $Background/V/M/DemonStatsContainer/FactionLabel
@onready var delete_button : TextureButton = $ForegroundInterfaceContainer/DeleteDemonButton


# Called when the node enters the scene tree for the first time.
func _ready():
	demon_sub_viewport.add_child(displayed_demon)
	displayed_demon.position = demon_camera3d.position - Vector3(0, 1, 2)
	
	name_label.text = displayed_demon.NAME
	hp_label.text = "HP: %s" % str(displayed_demon.STATS["Health"])
	power_label.text = "Power: %s" %  str(displayed_demon.STATS["Power"])
	faction_label.text = "Faction: %s" %  str(displayed_demon.STATS["Fraction"])
	
	tooltip_text = create_tooltip_string_from_demon(displayed_demon)
	
	connect_signals()


func create_tooltip_string_from_demon(demon : Demon) -> String:
	var result : String = ""
	result += "Name: %s\n" % demon.NAME
	result += "Age: %d\n" % 69
	for stat_name in demon.STATS:
		result += "%s: %s\n" %[stat_name, str(demon.STATS[stat_name])]
	return result


func on_delete_pressed():
	demon_sub_viewport.remove_child(displayed_demon)
	disconnect_signals()
	deleted.emit(self)


func connect_signals():
	delete_button.pressed.connect(on_delete_pressed)


func disconnect_signals():
	delete_button.pressed.disconnect(on_delete_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

