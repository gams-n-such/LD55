extends CanvasLayer

# for debugging
var accepted_names = []
var declined_names = []

# global variables
var accepted_demons = []
var cards_stack = []

var legion_panel_node : LegionPanel = load("res://Demon_assets/legion/legion_panel.tscn").instantiate()

func _ready():
	for i in 5:
		cards_stack.push_back(load("res://Demon_assets/demon_card.tscn").instantiate())
	(cards_stack.back() as Demon_card).accepted.connect(on_card_accepted)
	(cards_stack.back() as Demon_card).declined.connect(on_card_declined)
	add_child(cards_stack.back())
	
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
	legion_panel_node.add_displayed_demon(card.demon)
	Game.player_state.player_legion.add_demon(card.demon)
	pass

func on_card_declined(card : Demon_card):
	declined_names.push_back(card.demon.NAME)
	reset_current_card()
	pass
