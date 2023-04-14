extends Control


var TimePoint:PackedScene = preload("res://Editor/TimeLine/TimePoint.tscn")
var TimeSeparator:PackedScene = preload("res://Editor/TimeLine/TimeSeparator.tscn")
var pixels_per_second = 26
var level_time:int = 100#G.selected_level_file["time"]
var level_path:int = 3#G.selected_level_file["path"]


func _ready() -> void:
	self.size.x = pixels_per_second*level_time
	for i in range(level_time):
		var cordx = pixels_per_second*i
		var TimeSeparator_new = TimeSeparator.instantiate()
		TimeSeparator_new.position.x = cordx
		TimeSeparator_new.get_child(0).text = str(i)
		%TextureRect.add_child(TimeSeparator_new)


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		var second_on_timeline = int(get_global_mouse_position().x/(1280/level_time))
		var TimePoint_new = TimePoint.instantiate()
		print(second_on_timeline)
		TimePoint_new.position.x = second_on_timeline* (1280/level_time)
		%TextureRect.add_child(TimePoint_new)

