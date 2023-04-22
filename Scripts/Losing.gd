extends Control


func _on_restart_pressed():
	get_tree().paused = false
	G.change_scene("level_inst")
	#G.change_scene("game"+str(G.selected_lvl))


func _on_menu_pressed():
	get_tree().paused = false
	Au.MenuSoundPlay()
	G.change_scene("menu")
