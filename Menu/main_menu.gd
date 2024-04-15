extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_pressed():
	Game.switch_to_sandbox_level()


func _on_how_to_play_pressed():
	Game.switch_to_how_to_play_level()


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()


func _on_ui_test_lvel_pressed():
	get_tree().change_scene_to_file("res://Levels/ui_test_scene.tscn")
