extends Control

@onready var PlaneEdit = preload("res://Editor/PLaneEdit/plane_edit.tscn")
@onready var PointInf = $VBoxContainer2/TimelinePointInformatios

var time_of_point: int #Секунда события
var path_number: int #Номер пути события


func specify_data(path,time): #Вывести информацию
	
	delete_planes()
	path_number = path
	time_of_point = time
	
	PointInf.text = str("Path: ",path_number,"  Time: ",time_of_point) #Отображение события
	
	for plane in G.EPE[str(path_number)][str(time_of_point)]:
		var P = PlaneEdit.instantiate()
		P.path = plane["path"]
		P.time = plane["time"]
		P.type = plane["type"]
		P.side = plane["side"]
		
		%Planes.add_child(P)
		P.inf_up()


func _on_window_close_requested(): #Закрыть окошко события
	#save_planes()
	if not G.EPE[str(path_number)].has(str(time_of_point)):
		get_parent().hide()
		delete_planes()
		return
	if G.EPE[str(path_number)][str(time_of_point)].size() == 0:
#		G.EPE[str(path_number)].erase([str(time_of_point)])
#		G.EPE.erase([str(path_number)])
#		print("УБРАЛ ", G.EPE[str(path_number)][str(time_of_point)])
		get_tree().get_first_node_in_group("Editor").delete_point(str(path_number),str(time_of_point))
	
	get_parent().hide()
	delete_planes()








func _on_create_plane_ed_pressed(): #Добавить макет самолета в окошко
	if %Planes.get_children().size() == 2:
		return
	
	var P = PlaneEdit.instantiate()
	P.path = path_number
	P.time = time_of_point
	
	%Planes.add_child(P)





func save_planes(): #Сохранить все самолеты в событии
	print("\nСамолеты сохранены\n путь: ",path_number," cекунда: ",time_of_point)
	
	G.EPE[str(path_number)][str(time_of_point)] = [] #Обнуляю массив для того чтобы не плодить повторения
	
	for i in %Planes.get_children():
		var PLANE = i.get_assemb_plane() #Cловарь самолета
		if PLANE != null: #Проверяю корректен ли самолет
			print(" - ",PLANE)
			
			if PLANE["path"] != path_number or PLANE["time"] != time_of_point: #Если время или путь самолета не равен событию окошка
				if check_for_availability_pane(PLANE): #Проверка на перемещение самолета на другую точку события
					get_tree().get_first_node_in_group("Editor").get_line(str(PLANE["path"])).place_point_from_second_plane(str(PLANE["time"])) #Добавляю
					i.queue_free() #Удаляю из окошка
				else:
					i.mark()
			
			else:
				save_plane_file(PLANE) #Добавляю в массив
	get_tree().get_first_node_in_group("Editor").update_point(str(path_number),str(time_of_point)) #Обновляем информацию на точке



func check_for_availability_pane(PLANE): #Проверка на перемещение самолета на другую точку события
	var time_plane = str(PLANE["time"])
	var path_plane = str(PLANE["path"])
	
	var a_path_plane = G.EPE[path_plane]
	
	if a_path_plane.has(time_plane): #Если есть добавляю
		var a_array_plane = G.EPE[path_plane][time_plane]
		
		if a_array_plane.size() == 2: #Если массив полон
			return false
		
		if a_array_plane.size() == 1: #Если в массиве один самолет
			if a_array_plane[0]["side"] == PLANE["side"]: #Если стороны равны
				return false
		
		if a_array_plane.size() == 0: #Если в массив пуст
			G.EPE[str(PLANE["path"])][str(PLANE["time"])].append(PLANE)
			return true
	else:
		G.EPE[str(PLANE["path"])][str(PLANE["time"])] = [] #Если нету создаю потом добавляю
		G.EPE[str(PLANE["path"])][str(PLANE["time"])].append(PLANE)
		return true



func save_plane_file(plane): #Сохранить еденицу самолета
	G.EPE[str(path_number)][str(time_of_point)].append(plane)





func delete_planes(): #Удалить все самолеты в боксе
	for i in %Planes.get_children():
		i.queue_free()


func _on_save_pressed(): #Кнопка сохранения
	save_planes()



