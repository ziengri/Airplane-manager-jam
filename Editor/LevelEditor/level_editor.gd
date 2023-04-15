extends Node2D

var timeLine = preload("res://Editor/TimeLine/time_line.tscn")

var level_time:int = G.selected_level_file["time"]
var level_path:int = G.selected_level_file["path"]


func _ready() -> void:
	for i in range(1,level_path+1):
		var timeLine_new = timeLine.instantiate()
		timeLine_new.path_number = i
		%VBoxContainer.add_child(timeLine_new)
	
	print("Имя уровня: ",G.selected_level_file["name"])
	print("Время уровня: ",G.selected_level_file["time"])
	print("Пути уровня: ",G.selected_level_file["path"])
	print("Самолеты уровня: ",G.selected_level_file["Planes"],"\n")
