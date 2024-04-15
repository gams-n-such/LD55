extends PanelContainer
class_name Chat

signal new_msg(msg : String)

func _ready():
	send_message("from me", true)
	send_message("to me", false)
	send_message("from me again", true)
	send_message("one more time", true)
	var answers = [
		["option 1", 1],
		["option 2", 2],
		["option 3", 3]
	]
	add_answer_options(answers)

func change_stage(stage : int):
	# TODO
	pass

func send_message(msg : String, from_me : bool):
	var stylebox := StyleBoxFlat.new()
	var label := Label.new()
	var margin := MarginContainer.new()
	var panel := PanelContainer.new()
	
	stylebox.set_corner_radius_all(5.0)
	
	label.text = msg
	
	margin.add_theme_constant_override("margin_left", 5)
	margin.add_theme_constant_override("margin_right", 5)
	
	panel.add_theme_stylebox_override("panel", stylebox)
	
	margin.add_child(label)
	panel.add_child(margin)
	
	if from_me:
		panel.set_h_size_flags(Control.SIZE_SHRINK_END)
		stylebox.bg_color = Color.CORNFLOWER_BLUE
	else:
		panel.set_h_size_flags(Control.SIZE_SHRINK_BEGIN)
		stylebox.bg_color = Color.PLUM
	
	%ChatHistory.add_child(panel)
	new_msg.emit(msg)

func on_answer_pressed(answer : String, id : int):
	print("answer : ", id)
	send_message(answer, true)
	
	for i in %AnswerOptions.get_child_count():
		%AnswerOptions.get_child(i).pressed.disconnect(on_answer_pressed)
		%AnswerOptions.get_child(i).queue_free()
	
	# TODO
	change_stage(id)

func add_answer_options(answers):
	for i in answers.size():
		var new_answer := Answer.new(answers[i][0], answers[i][1])
		new_answer.pressed.connect(on_answer_pressed)
		%AnswerOptions.add_child(new_answer)
