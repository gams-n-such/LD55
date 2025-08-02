class_name TinderCard extends Control

var _demon : DemonInstance
@export var demon : DemonInstance:
	get:
		return _demon
	set(value):
		_demon = value
		update_demon_info()

@onready var name_label : Label = %DemonNameLabel
@onready var class_label : Label = %DemonClassLabel

func update_demon_info():
	if not demon:
		return
	name_label.text = demon.demon_name
	class_label.text = demon.demon_type.label
	# TODO: stats

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_dislike_pressed() -> void:
	demon.queue_free()
	_discard_card(false)

func _on_like_pressed() -> void:
	# TODO: sacrifices
	Game.hire_demon(demon, [])
	_discard_card(true)

func _discard_card(like : bool) -> void:
	# TODO: animation
	queue_free()
