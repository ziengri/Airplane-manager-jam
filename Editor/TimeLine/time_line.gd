extends Control


var TimePoint:PackedScene = preload("res://Editor/TimePoint/TimePoint.tscn")
var TimeSeparator:PackedScene = preload("res://Editor/TimeSeparator/TimeSeparator.tscn")
var WindowPoint: PackedScene = preload("res://Editor/Window/window.tscn")

var pixels_per_second = 26#+4
var level_time:int = Fs.selected_level_file["time"]
var level_path:int = Fs.selected_level_file["path"]
var path_number:int


func _ready() -> void:
	name = str(path_number)
	
	self.custom_minimum_size.x = pixels_per_second*(level_time+1)
	
#	if level_time < 50:
#		pixels_per_second = 1280/(level_time-1)

	
	for i in range(level_time+1):
		var cordx = pixels_per_second*i #Кордината метки
		
		var TimeSeparator_new = TimeSeparator.instantiate() #Cоздание метки
		
		TimeSeparator_new.position.x = cordx
		TimeSeparator_new.get_child(0).text = str(i)
		%TextureRect.add_child(TimeSeparator_new)


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		
		#Расчитать секунду клика
		var second_on_timeline = int(get_local_mouse_position().x/pixels_per_second)*pixels_per_second
		
		#Создать точку события
		place_poit(second_on_timeline)




#Разместить точку на таймлайне
func place_poit(second_on_timeline):
	if has_node(str((second_on_timeline/pixels_per_second))):
		print("УЖЕ ЕСТЬ")
		return
	
	G.EPE[str(path_number)][str((second_on_timeline/pixels_per_second))] = [] #Создать событие в словаре
	
	var second = int(second_on_timeline/pixels_per_second)
	
	var point = create_point(second_on_timeline,second,path_number)  #Создать точку на таймлайне
	add_child(point)
	
	point.opem_window() 

#Разместить точку на таймлайне при запуске
func place_point_from_second(second): 
	var second_on_timeline = (pixels_per_second*int(second))
	
	var point = create_point(second_on_timeline,second,path_number) 
	add_child(point)    
  
func place_point_from_second_plane(second):
	if has_node(second):
		get_node(second).save_point()
	else:
		var second_on_timeline = (pixels_per_second*int(second))
		var point = create_point(second_on_timeline,second,path_number) 
		add_child(point)    
	
	print(get_node(second))

#Создать точку
func create_point(second_on_timeline,second,path):
	var TimePoint_new = TimePoint.instantiate()
	TimePoint_new.position.x = second_on_timeline #+6
	TimePoint_new.selftime = second #Задать секунду точке
	TimePoint_new.selfpath = path #Задать путь точке
	return TimePoint_new





#Функция создания окошка события
func create_window(second_on_timeline): 
	var Win = WindowPoint.instantiate()
	
	#Передать информацию о секунде события
	Win.get_child(0).time_of_point = second_on_timeline/pixels_per_second
	Win.get_child(0).path_number = path_number
	
	get_tree().get_first_node_in_group("Editor").add_child(Win)
