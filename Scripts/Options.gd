extends Control



func _on_fullscreen_pressed():
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED


func _on_menu_pressed():
	get_parent().switching($"../Main_menu")


var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	#return
	var val = -30
	AudioServer.set_bus_volume_db(master_bus,val)
	$MarginContainer/VBoxContainer/SoundVolume/HSlider.value = val
	if val == -30:
		AudioServer.set_bus_mute(master_bus,true)
	pass

func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus,value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
