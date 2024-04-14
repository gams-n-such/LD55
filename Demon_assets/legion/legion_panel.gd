class_name LegionPanel extends Control

var displayed_demons : Array[Demon] = Game.player_state.player_legion.legion
var displayed_legion_cards : Array[LegionCard] = []

@onready var demon_cards_scroll_container : VBoxContainer = $Background/M/V/DemonCardsScrollContainer/DemonCardsContainer

var scene = preload("res://Demon_assets/legion/card/legion_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for demon in displayed_demons :
		var card = load("res://Demon_assets/legion/card/legion_card.tscn").instantiate()
		(card as LegionCard).displayed_demon = demon
		displayed_legion_cards.append(card)
	for card in displayed_legion_cards :
		demon_cards_scroll_container.add_child(card)
		(card as LegionCard).deleted.connect(on_card_delete_pressed)


func on_card_delete_pressed(card : LegionCard):
	Game.player_state.player_legion.remove_demon(card.displayed_demon)
	displayed_legion_cards.remove_at(displayed_legion_cards.find(card))
	demon_cards_scroll_container.remove_child(card)


func add_displayed_demon(demon : Demon):
	var card = load("res://Demon_assets/legion/card/legion_card.tscn").instantiate()
	#card.get_script()
	(card as LegionCard).displayed_demon = demon
	displayed_legion_cards.append(card)
	demon_cards_scroll_container.add_child(card)
	(card as LegionCard).deleted.connect(on_card_delete_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
