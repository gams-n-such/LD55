extends Button
class_name Answer

signal pressed_from(from : Answer)

func _init(str : String = ""):
	self.text = str

func _on_pressed():
	pressed_from.emit(self)
