extends Control


func _ready():
	pass


func _process(_delta):
	pass


func _on_start_pressed():
	Game.switch_to_sandbox_level()


func _on_how_to_play_pressed():
	Game.switch_to_how_to_play_level()


func _on_options_pressed():
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_ui_test_lvel_pressed():
	get_tree().change_scene_to_file("res://Levels/ui_test_scene.tscn")
