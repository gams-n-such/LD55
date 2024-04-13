extends CanvasLayer

var accepted_names = []
var declined_names = []
var cards_stack = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 5:
		cards_stack.push_back(load("res://Demon_assets/demon_card.tscn").instantiate())
	(cards_stack.back() as Demon_card).accepted.connect(on_card_accepted)
	(cards_stack.back() as Demon_card).declined.connect(on_card_declined)
	add_child(cards_stack.back())

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
	accepted_names.push_back(card.demon.Name)
	reset_current_card()
	pass

func on_card_declined(card : Demon_card):
	declined_names.push_back(card.demon.Name)
	reset_current_card()
	pass
