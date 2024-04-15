extends CanvasLayer

class_name Demon_card

signal accepted(from : Demon_card)
signal declined(from : Demon_card)


@export var accept:BaseButton
@export var decline:BaseButton

var demon
var demon3d

func get_3d_demon():
	return %SubViewport/Privew3dDemon/demon_look
	

func _enter_tree():
	demon = load("res://Demon_assets/Demon.tscn").instantiate()
	demon3d = load("res://privew_3d_demon.tscn").instantiate()
	print("my name is:"+name)

#@onready var demon = load("res://Demon_assets/Demon.tscn").instantiate()
@onready var ANIMATION_DURATION := 0.75


func _ready():
	# add demon to subviewport for preview
	%SubViewport.add_child(demon3d)
	#demon.position = %Camera3D.position - Vector3(0, 1, 2)
	
	# set name and age
	%name.text = demon.NAME
	%age.text = str(randi_range(100, 9999))
	
	# set stats
	var stats_grid := %stats_grid
	for stat_name in demon.STATS:
		var stat_name_label := Label.new()
		var stat_value_label := Label.new()
		stat_name_label.text = stat_name
		stat_value_label.text = str(demon.STATS[stat_name])
		stats_grid.add_child(stat_name_label)
		stats_grid.add_child(stat_value_label)
	
	# connect to button presses
	connect_signals()

func on_accept_pressed():
	%SubViewport.remove_child(demon)
	disconnect_signals()
	accepted.emit(self)
	animate_and_free(true)

func on_decline_pressed():
	%SubViewport.remove_child(demon)
	disconnect_signals()
	declined.emit(self)
	animate_and_free(false)

func animate_and_free(accepted : bool):
	var alpha_tween = get_tree().create_tween()
	var pos_tween = get_tree().create_tween()
	if accepted == true:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.GREEN, 0.0), ANIMATION_DURATION)
		pos_tween.tween_property($PanelContainer, "position", $PanelContainer.position + Vector2(100, 0), ANIMATION_DURATION)
	else:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.RED, 0.0), ANIMATION_DURATION)
		pos_tween.tween_property($PanelContainer, "position", $PanelContainer.position + Vector2(-100, 0), ANIMATION_DURATION)
	pos_tween.tween_callback(queue_free)

func connect_signals():
	%accept.pressed.connect(on_accept_pressed)
	%decline.pressed.connect(on_decline_pressed)

func disconnect_signals():
	%accept.disabled = true
	%decline.disabled = true
	%accept.pressed.disconnect(on_accept_pressed)
	%decline.pressed.disconnect(on_decline_pressed)
