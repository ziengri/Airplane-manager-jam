extends Node

func _ready():
	switching($Main_menu)
	G.selected_level_file = {}
#Функция показывания раздела меню
func switching(node):
	Au.UiPlay()
	node.show()
	for i in self.get_children():
		if node != i and i != $ColorRect:
			i.hide()

