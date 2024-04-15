extends Node

static func get_stage_by_id(id : int):
	return D[id]

const D := {
	0 : {},
	1 : {
		"Question" : "Hello, handsome",
		"Answers" : [
			["Hi, qt", 2],
			["God damn you got some stats!", 2],
			["Those horns of yours make me want to take over the world", 2],
			["Actualy i'm cristian", -1]
		]
	},
	2 : {
		"Question" : "What do you think about world domination?",
		"Answers" : [
			["Not a fan", -1],
			["Sounds fun", 3]
		]
	},
	3 : {
		"Question" : "I'm not your typical demon. I require attention and sacrifices",
		"Answers" : [
			["I'll do anything you want", 4],
			["Sure, how much?", 4],
			["All of you demons are same. I need a demon who is interested in me", -1]
		]
	},
	4 : {
		"Question" : "You know what i need",
		"Answers" : [
			["DEBUG_OPTION::Enough sacrifices", 5],
			["DEBUG_OPTION::Not enough sacrifices", -1]
		]
	},
	5 : {
		"Question" : "Let's kill some people!",
		"Answers" : []
	},
	-1 : {
		"Question" : "You are not disgusting enogh",
		"Answers" : []
	}
}
