extends PanelContainer
class_name Answer

signal pressed(answer : String, id : int)

var id : int

func _init(answer_string : String = "", stage_id : int = 0):
	id = stage_id
	var label = Label.new()
	var button := Button.new()
	add_child(label)
	add_child(button)
	label.text = answer_string
	button.pressed.connect(on_button_pressed)

func on_button_pressed():
	pressed.emit(get_child(0).text, id)
