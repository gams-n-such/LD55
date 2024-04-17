extends CanvasLayer

# for debugging
var accepted_names = []
var declined_names = []

# global variables
var accepted_demons = []
var cards_stack = []

var legion_panel_node : LegionPanel

@export var d3d:Demons3D
@export var demon_count=5


func _ready():
	return
	for i in 5:
		cards_stack.push_back(load("res://Demon_assets/Tinder/demon_card.tscn").instantiate())
	(cards_stack.back() as Demon_card).accepted.connect(on_card_accepted)
	(cards_stack.back() as Demon_card).declined.connect(on_card_declined)
	add_child(cards_stack.back())
	legion_panel_node = load("res://Demon_assets/legion/legion_panel.tscn").instantiate()
	add_child(legion_panel_node)

func reset_current_card():
	if not cards_stack.is_empty():
		(cards_stack.back() as Demon_card).accepted.disconnect(on_card_accepted)
		(cards_stack.back() as Demon_card).declined.disconnect(on_card_declined)
		cards_stack.pop_back()
	
	if not cards_stack.is_empty():
		(cards_stack.back() as Demon_card).accepted.connect(on_card_accepted)
		(cards_stack.back() as Demon_card).declined.connect(on_card_declined)
		add_child(cards_stack.back())
		move_child(cards_stack.back(), 0)
	else:
		print("accepted : ")
		print(str(accepted_names))
		print("declined : ")
		print(str(declined_names))

func on_card_accepted(card : Demon_card):
	accepted_names.push_back(card.demon.NAME)
	accepted_demons.push_back(card.demon)
	reset_current_card()
	d3d.show(card.get_3d_demon())
	for desire : Desire in card.demon.STATS["Desires"] :
		desire.apply(card.demon)
	legion_panel_node.add_displayed_demon(card.demon)
	Game.hire_demon(card.demon, [])

func on_card_declined(card : Demon_card):
	declined_names.push_back(card.demon.NAME)
	reset_current_card()
	pass
