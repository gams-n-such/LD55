extends CanvasLayer

class_name Demon_card

signal accepted(from : Demon_card)
signal declined(from : Demon_card)

@onready var demon = load("res://Demon_assets/Demon.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/Info_vbox/Name_age_vbox/name.text = demon.NAME
	$PanelContainer/SubViewportContainer/SubViewport.add_child(demon)
	demon.position = $PanelContainer/SubViewportContainer/SubViewport/Camera3D.position - Vector3(0, 1, 2)
	connect_signals()
	pass

func on_accept_pressed():
	$PanelContainer/SubViewportContainer/SubViewport.remove_child(demon)
	disconnect_signals()
	accepted.emit(self)
	animate_and_free(true)

func on_decline_pressed():
	$PanelContainer/SubViewportContainer/SubViewport.remove_child(demon)
	disconnect_signals()
	declined.emit(self)
	animate_and_free(false)

func animate_and_free(accepted : bool):
	var alpha_tween = get_tree().create_tween()
	var pos_tween = get_tree().create_tween()
	if accepted == true:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.GREEN, 0.0), 2.0)
		pos_tween.tween_property($PanelContainer, "position", $PanelContainer.position + Vector2(100, 0), 2.0)
	else:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.RED, 0.0), 2.0)
		pos_tween.tween_property($PanelContainer, "position", $PanelContainer.position + Vector2(-100, 0), 2.0)
	pos_tween.tween_callback(queue_free)

func connect_signals():
	$PanelContainer/Info_vbox/MarginContainer3/HBoxContainer/MarginContainer2/accept.pressed.connect(on_accept_pressed)
	$PanelContainer/Info_vbox/MarginContainer3/HBoxContainer/MarginContainer/decline.pressed.connect(on_decline_pressed)

func disconnect_signals():
	$PanelContainer/Info_vbox/MarginContainer3/HBoxContainer/MarginContainer2/accept.pressed.disconnect(on_accept_pressed)
	$PanelContainer/Info_vbox/MarginContainer3/HBoxContainer/MarginContainer/decline.pressed.disconnect(on_decline_pressed)
