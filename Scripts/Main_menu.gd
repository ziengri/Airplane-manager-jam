extends Control






#Выбор уровня
func _on_play_pressed():
	Au.UiPlay()
	G.change_scene("level_selection")

#Опции
func _on_options_pressed():
	get_parent().switching($"../Options")

#Авторы
func _on_authors_pressed():
	get_parent().switching($"../Authors")

#Выход
func _on_exit_pressed():
	get_tree().quit()


func _on_button_pressed():
	Au.UiPlay()
	G.change_scene("level_edit_menu")
