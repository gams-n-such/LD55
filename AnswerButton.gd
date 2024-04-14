extends Button
class_name Answer

signal pressed_from(from : Answer)

func _init(str : String = ""):
	$Answer.text = str

func _on_button_pressed():
	pressed_from.emit(self)
