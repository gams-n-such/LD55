extends CanvasLayer

class_name Demon_card

signal accepted(from : Demon_card)
signal declined(from : Demon_card)

@onready var demon = load("res://Demon_assets/Demon.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/Info_vbox/Name_age_vbox/name.text = demon.Name
	connect_signals()
	pass

func _on_accept_pressed():
	disconnect_signals()
	accepted.emit(self)
	animate_and_free(true)

func _on_decline_pressed():
	disconnect_signals()
	declined.emit(self)
	animate_and_free(false)

func animate_and_free(accepted : bool):
	var alpha_tween = get_tree().create_tween()
	var pos_tween = get_tree().create_tween()
	if accepted == true:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.GREEN, 0.0), 2.0)
		pos_tween.tween_property($PanelContainer, "position", Vector2(510.0, 14), 2.0)
	else:
		alpha_tween.tween_property($PanelContainer, "modulate", Color(Color.RED, 0.0), 2.0)
		pos_tween.tween_property($PanelContainer, "position", Vector2(310.0, 14), 2.0)
	pos_tween.tween_callback(queue_free)

func connect_signals():
	$PanelContainer/Info_vbox/Buttons_grid/HBoxContainer/accept.pressed.connect(_on_accept_pressed)
	$PanelContainer/Info_vbox/Buttons_grid/HBoxContainer/decline.pressed.connect(_on_decline_pressed)

func disconnect_signals():
	$PanelContainer/Info_vbox/Buttons_grid/HBoxContainer/accept.pressed.disconnect(_on_accept_pressed)
	$PanelContainer/Info_vbox/Buttons_grid/HBoxContainer/decline.pressed.disconnect(_on_decline_pressed)
