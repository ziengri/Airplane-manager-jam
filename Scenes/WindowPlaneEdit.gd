extends Control

@onready var PlaneEdit = preload("res://plane_edit.tscn")
@onready var Point = $VBoxContainer/TimelinePoint

func _on_create_plane_ed_pressed():
	var P = PlaneEdit.instantiate()
	P.time = Point.text
	$VBoxContainer.add_child(P)


func _on_window_close_requested():
	print("add_plane")
	G.selected_level_file["Planes"] = []
	for i in $VBoxContainer.get_children():
		if i == $VBoxContainer/TimelinePoint or i == $VBoxContainer/CreatePlaneEd or i == $VBoxContainer/S :
			pass
		elif i.get_assemb_plane() != null:
			save_plane(i.get_assemb_plane())
	print(G.selected_level_file)


func save_plane(plane):
	G.selected_level_file["Planes"].append(plane)
	
	var file = FileAccess.open("user://levels/"+G.selected_level_file["name"]+".txt", FileAccess.WRITE)
	file.store_var(G.selected_level_file)


