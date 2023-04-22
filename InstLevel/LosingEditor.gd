extends Control

func _on_continue_pressed():
	get_tree().paused = false
	hide()


func _on_close_pressed():
	get_tree().paused = false
	get_tree().get_current_scene().remove_level()

