extends Control

@onready var PlaneEdit = preload("res://Editor/PLaneEdit/plane_edit.tscn")
@onready var PointInf = $VBoxContainer2/TimelinePointInformatios

var time_of_point: int #Секунда события
var path_number: int #Номер пути события


func _on_create_plane_ed_pressed(): #Добавить макет самолета в окошко
	if %Planes.get_children().size() == 2:
		return
	
	var P = PlaneEdit.instantiate()
	P.path = path_number
	P.time = time_of_point
	
	%Planes.add_child(P)


func _ready():
	PointInf.text = str("Path: ",path_number,"  Time: ",time_of_point) #Отображение события
	pass


func _on_window_close_requested(): #Закрыть окошко события
	save_planes()
	get_parent().queue_free()


func save_planes(): #Сохранить самолеты в событии
	print("\nСамолеты сохранены:")
	
	G.selected_level_file["Planes"] = [] #Обнуляю массив для того чтобы не плодить повторения
	for i in %Planes.get_children():
		if i.get_assemb_plane() != null: #Проверяю корректен ли самолет
			print(" - ",i.get_assemb_plane())
			save_plane_file(i.get_assemb_plane()) #Добавляю в массив
	
	print("\nвсе самолеты",G.selected_level_file["Planes"],"\n")


func delete_planes(plane): #Удалить самолет
	for i in %Planes.get_children():
		if i == plane:
			i.queue_free()


func save_plane_file(plane): #Сохранить еденицу самолета
	G.selected_level_file["Planes"].append(plane)
	
	var file = FileAccess.open("user://levels/"+G.selected_level_file["name"]+".txt", FileAccess.WRITE)
	file.store_var(G.selected_level_file)


func match_check(plane): #Проверка на совпадение side самолетов
	for i in %Planes.get_children():
		if i != plane:
			if i.side == plane.side:
				return false
	return true


func _on_save_pressed(): #Кнопка сохранения
	save_planes()
