extends Control


func _on_next_level_pressed():
	get_tree().paused = false
	G.change_scene("game"+str(G.selected_lvl))
