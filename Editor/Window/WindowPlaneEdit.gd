extends Control

@onready var PlaneEdit = preload("res://Editor/PLaneEdit/plane_edit.tscn")
@onready var PointInf = $VBoxContainer2/TimelinePointInformatios

var time_of_point: int #Секунда события
var path_number: int #Номер пути события

func _on_create_plane_ed_pressed():
	var P = PlaneEdit.instantiate()
	P.time = PointInf.text
	%Planes.add_child(P)

func _ready():
	PointInf.text = str(time_of_point)
	pass

func _on_window_close_requested(): #Закрыть окошко события
	save_planes()
	get_parent().queue_free()

func save_planes(): #Сохранить самолеты в событии
	print("\nСамолеты сохранены:")
	
	G.selected_level_file["Planes"] = []
	for i in %Planes.get_children():
		if i.get_assemb_plane() != null:
			print(" - ",i.get_assemb_plane())
			save_plane_file(i.get_assemb_plane())
	
	print("\nвсе самолеты",G.selected_level_file["Planes"],"\n")


func save_plane_file(plane): #Сохранить еденицу самолета
	G.selected_level_file["Planes"].append(plane)
	
	var file = FileAccess.open("user://levels/"+G.selected_level_file["name"]+".txt", FileAccess.WRITE)
	file.store_var(G.selected_level_file)




func _on_save_pressed():
	save_planes()
