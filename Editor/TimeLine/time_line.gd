extends Control


var TimePoint:PackedScene = preload("res://Editor/TimePoint/TimePoint.tscn")
var TimeSeparator:PackedScene = preload("res://Editor/TimeSeparator/TimeSeparator.tscn")
var WindowPoint: PackedScene = preload("res://Editor/Window/window.tscn")

var pixels_per_second = 26#+4
var level_time:int = G.selected_level_file["time"]
var level_path:int = G.selected_level_file["path"]
var path_number:int


func _ready() -> void:
	self.custom_minimum_size.x = pixels_per_second*(level_time+1)#Поменял на минимал сайз из за того что таймлайну размер задает БоксКонтейнер
	
	for i in range(level_time+1):
		#Кордината метки
		var cordx = pixels_per_second*i
		#Cоздание метки
		var TimeSeparator_new = TimeSeparator.instantiate()
		TimeSeparator_new.position.x = cordx
		TimeSeparator_new.get_child(0).text = str(i)
		%TextureRect.add_child(TimeSeparator_new)


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		print(get_local_mouse_position())
		
		#Расчитать секунду клика
		var second_on_timeline = int(get_local_mouse_position().x/pixels_per_second)*pixels_per_second
		print(int(get_local_mouse_position().x/pixels_per_second)*pixels_per_second)
		
		#Создать точку события
		createtime_poit(second_on_timeline)
		
		#Создать окошко события
		create_window(second_on_timeline) 



#Создать точку на таймлайне
func createtime_poit(second_on_timeline):
	var TimePoint_new = TimePoint.instantiate()
	TimePoint_new.position.x = second_on_timeline +6 #+ 8
	%TextureRect.add_child(TimePoint_new)



#Функция создания окошка события
func create_window(second_on_timeline): 
	var Win = WindowPoint.instantiate()
	
	#Передать информацию о секунде события
	Win.get_child(0).time_of_point = second_on_timeline/pixels_per_second
	Win.get_child(0).path_number = path_number
	
	get_tree().get_first_node_in_group("Editor").add_child(Win)
