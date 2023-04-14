extends Node2D

var timeLine = preload("res://Editor/TimeLine/time_line.tscn")

var level_time:int = 100#G.selected_level_file["time"]
var level_path:int = 3#G.selected_level_file["path"]


func _ready() -> void:
	for i in range(level_path):
		var timeLine_new = timeLine.instantiate()
		%VBoxContainer.add_child(timeLine_new)
	
	print(G.selected_level_file)
