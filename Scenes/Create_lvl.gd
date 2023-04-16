extends Control

@onready var NameLevel = $MarginContainer/VBoxContainer/NameLevel/Control/TextEdit
@onready var LevelTime = $MarginContainer/VBoxContainer/LevelTime/Control/HSlider
@onready var NumberPaths = $MarginContainer/VBoxContainer/NumberPaths/Control/OptionButton
@onready var SlideTime = $MarginContainer/VBoxContainer/LevelTime/Control/Label

var time_l = 20
var path_l = 2
var name_l: String

func _ready():
	LevelTime.connect("value_changed",_on_h_slider_value_changed)
	NumberPaths.connect("item_selected",_on_option_button_item_selected)


func _on_h_slider_value_changed(value):
	SlideTime.text = str(value)
	time_l = value


func _on_option_button_item_selected(index):
	path_l = int(NumberPaths.get_item_text(index))


func _on_create_pressed():
	if NameLevel.text == "":
		return
	
	if Fs.external_levels.keys().has(NameLevel.text):
		return
	
	name_l = NameLevel.text
	create_file_lvl()
	
	Fs.selected_level_file = Fs.external_levels[name_l]
	G.change_scene("level_editor")


func create_file_lvl():
	var create_lvl = {}
	create_lvl["name"] = name_l
	create_lvl["path"] = path_l
	create_lvl["time"] = time_l
	create_lvl["events"] = {}
	
	for path in range(1,create_lvl["path"]+1):
		create_lvl["events"][str(path)] = {}
	
	Fs.external_levels[name_l] = create_lvl
	
	var file = FileAccess.open("user://levels/"+name_l+".txt", FileAccess.WRITE,)
	file.store_var(create_lvl)
	
	

