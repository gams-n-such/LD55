extends PanelContainer
class_name Messenger_button

var chat : Chat

signal pressed(chat : Chat)

func _init(demon : Demon):
	

func _on_button_pressed():
	pressed.emit(chat)
