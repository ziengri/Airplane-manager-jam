extends Control

@onready var CreateMenu = $Create
@onready var OptButLoad = %OptionButton


func _input(event):
	if event.is_action_pressed("ESC"):
		G.change_scene("menu")

func switching(node):
	Au.UiPlay()
	node.show()
	for i in self.get_children():
		if node != i and i != $TextureRect:
			i.hide()


func _ready():
	OptButLoad.connect("item_selected",_on_option_button_item_selected)
	switching($Load)
	if Fs.external_levels == {}:
		$Load/MarginContainer/VBoxContainer/InfBox.hide()
		return
	
	for level in Fs.external_levels:
		OptButLoad.add_item(level)
	
	Fs.selected_level_file = Fs.external_levels[OptButLoad.get_item_text(0)]
	%Info.text = "Path: "+str(Fs.selected_level_file["path"])+"    Time: "+str(Fs.selected_level_file["time"])
	#$Load/MarginContainer/VBoxContainer/InfBox.hide()



func _on_create_level_pressed():
	switching(CreateMenu)


func _on_option_button_item_selected(index):
	Fs.selected_level_file = Fs.external_levels[OptButLoad.get_item_text(index)]
	%Info.text = "Path: "+str(Fs.selected_level_file["path"])+"    Time: "+str(Fs.selected_level_file["time"])


func _on_load_level_pressed():
	if Fs.selected_level_file != {}:
		G.change_scene("level_editor")
