extends Control


func _on_next_level_pressed():
	get_tree().paused = false
	var level = FileAccess.open("res://LevelFiles/"+str(G.selected_lvl)+".txt",FileAccess.READ)#("user://levels/"+"1.txt",FileAccess.READ)#
	var levelContent = level.get_var()
	print(levelContent)
	Fs.selected_level_file = levelContent
	G.change_scene("level_inst")
	#G.change_scene("game"+str(G.selected_lvl))
