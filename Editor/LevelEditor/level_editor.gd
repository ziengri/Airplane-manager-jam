extends Node2D

var timeLine = preload("res://Editor/TimeLine/time_line.tscn")

var level_time:int = Fs.selected_level_file["time"]
var level_path:int = Fs.selected_level_file["path"]

@onready var World = preload("res://InstLevel/world.tscn")
@onready var win = $CanvasLayer/Control/Window


func _ready() -> void:
	G.EPE = Fs.selected_level_file["events"] #Загрузить временную инфу
	
	for i in range(1,level_path+1): #Cоздать таймлайны
		var timeLine_new = timeLine.instantiate()
		timeLine_new.path_number = i
		%ContainerPath.add_child(timeLine_new)
	
	#Вывод информации уровня
	print("Имя уровня: ",Fs.selected_level_file["name"])
	print("Время уровня: ",Fs.selected_level_file["time"])
	print("Пути уровня: ",Fs.selected_level_file["path"])
	
	recalculate_events() #Создать все точки существующие в словаре
	win.hide() #Cкрыть окошко


func recalculate_events(): #Создать все точки существующие в словаре
	for path in G.EPE.keys():
		for second in G.EPE[path]:
			#print(second)
			%ContainerPath.get_child(int(path)-1).place_point_from_second(int(second))


func open_window(path,time): #Открыть окошко
	#win.position = Vector2(375,480)
	win.show()
	win.get_child(0).specify_data(path,time)

func close_window(path,time):
	win.get_child(0).close_window(path,time)

func close_window_(selfpath,selftime):
	win.hide()

func update_point(path,second): #Обновить данные точки
	%ContainerPath.get_node(path).get_node(second).display_side()

func delete_point(path,second): #Удалить точку с таймлайна
	%ContainerPath.get_node(path).get_node(second).self_delete_point()

func get_line(path):
	return %ContainerPath.get_node(path)



func sort_ascending(a, b):
	if a < b:
		return true
	return false

func sort_file():
	var array_second: Dictionary
	var array_second_: Dictionary
	
	for path in G.EPE.keys():
		array_second[path] = []
		array_second_[path] = {}
		var arr: Array = array_second[path]
		for second in G.EPE[path].keys():
			var sec = int(second)
			arr.append(sec)
		arr.sort_custom(sort_ascending)
		for key in array_second[path]:
			array_second_[path][str(key)] = G.EPE[path][str(key)]
	
	print("array: ",array_second_)
	G.EPE = array_second_

func save_file():
	sort_file()
	Fs.selected_level_file["events"] = G.EPE
	
	Fs.external_levels[Fs.selected_level_file["name"]] = Fs.selected_level_file
	
	var file = FileAccess.open("user://levels/"+Fs.selected_level_file["name"]+".txt", FileAccess.WRITE,)
	file.store_var(Fs.selected_level_file)

func _on_save_pressed(): #Сохранить файл
#	if vkl:
#		for path in Fs.selected_level_file["events"]:
#			for second in Fs.selected_level_file["events"][path]:
#				for plane in Fs.selected_level_file["events"][path][second]:
#					if plane["side"] == 1:
#						plane["side"] = "Right"
#					else:
#						plane["side"] = "Left"
#	print("\n")
#	for path in G.EPE.keys():
#		print("PATH ",path)
#		print(G.EPE[path].keys())
#		#print("\n")
	

	save_file()
	G.change_scene("menu")

#var vkl = false
func _on_launch_pressed():
#	vkl = true
	save_file()
	var test_level = World.instantiate()
	$CanvasLayer.hide()
	$TestLevelScene.add_child(test_level)
	win.hide()
	
func remove_level():
	$TestLevelScene.get_child(0).queue_free()
	$CanvasLayer.show()
