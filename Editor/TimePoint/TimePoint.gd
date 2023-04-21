extends Panel

@onready var Lavel = $Label

var selftime: int 
var selfpath: int

func _ready():
	name = str(selftime) #Задать имя по секунде события
	display_side()



func display_side(): #Обновить информацию о сторонах полета самолетов
	if G.EPE[str(selfpath)][str(selftime)].size() == 0:
		Lavel.text = ""
	
	elif G.EPE[str(selfpath)][str(selftime)].size() == 2:
		Lavel.text = "><"
	
	else:
		match G.EPE[str(selfpath)][str(selftime)][0]["side"]:
			"Right":
				Lavel.text = "<"
			"Left":
				Lavel.text = ">"
				

func save_point(): #ХЗ
	if G.EPE[str(selfpath)][str(selftime)].size() == 0:
		queue_free()
	display_side()

func opem_window(): #Показать окошко с информацией о событии
	get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime)
	pass

func self_delete_point(): #Удалить точку как и на таймлайне так и в файле
	
	var p: Dictionary = G.EPE[str(selfpath)]
	var t = str(selftime)
	get_tree().get_first_node_in_group("Editor").close_window(selfpath,selftime)
	p.erase(t)
	#print(G.EPE)
	
	queue_free()

var per:bool
var pos_old

func _physics_process(delta):
	if per:
		var a = get_parent().get_local_mouse_position()
		var b = Vector2(snappedi(a.x,26),snappedi(a.y,26))
		position.x = b.x + 6

func _on_gui_input(event):  #Нажатия на точку
	if event.is_action_pressed("center_mouse_click"):
		get_tree().get_first_node_in_group("Editor").close_window_(selfpath,selftime)
		pos_old = position
		per = true
	if event.is_action_released("center_mouse_click"):
		per = false
		var selftime_new = int(position.x/26)
		var p: Dictionary = G.EPE[str(selfpath)]
		var t: String = str(selftime)
		if selftime_new > Fs.selected_level_file["time"] or selftime_new < 0: #Запрет за пределы
			position = pos_old
			return
		if G.EPE[str(selfpath)].has(str(selftime_new)): #Если событие уже существует
			var number = G.EPE[str(selfpath)][str(selftime)].size()
			var number_new = G.EPE[str(selfpath)][str(selftime_new)].size()
			
			if (number + number_new) > 2: #Если сумма больше 2
				position = pos_old
				return
			
			if (number + number_new) == 0: #Если сумма 0
				G.EPE[str(selfpath)].erase(t) #Убираем свой массив
				get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new)#Окошко слитое событие
				self_delete_point() #Окошко наше пустое событие
			
			if (number + number_new) == 2: #Если 1 и 1
				if number == 2: #Наше событие 2 самолета
					G.EPE[str(selfpath)][str(selftime)][0]["time"] = int(selftime_new)
					G.EPE[str(selfpath)][str(selftime_new)].append(G.EPE[str(selfpath)][str(selftime)][0])
					G.EPE[str(selfpath)][str(selftime)][1]["time"] = int(selftime_new)
					G.EPE[str(selfpath)][str(selftime_new)].append(G.EPE[str(selfpath)][str(selftime)][1])
					G.EPE[str(selfpath)].erase(t) #Убираем свой массив
					get_tree().get_first_node_in_group("Editor").update_point(str(selfpath),str(selftime_new)) #Обновить слитое событие
					get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new) #Окошко слитое событие
					self_delete_point() #Окошко наше пустое событие
				elif number_new == 2: #Наше событие пустое
					G.EPE[str(selfpath)].erase(t) #Убираем свой массив
					get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new)#Окошко слитое событие
					self_delete_point() #Окошко наше пустое событие
				elif G.EPE[str(selfpath)][str(selftime_new)][0]["side"] == G.EPE[str(selfpath)][str(selftime)][0]["side"]: #Cтороны равны
					position = pos_old
					return
				elif G.EPE[str(selfpath)][str(selftime_new)][0]["side"] != G.EPE[str(selfpath)][str(selftime)][0]["side"]: #Cтороны не равны
					G.EPE[str(selfpath)][str(selftime)][0]["time"] = int(selftime_new)
					G.EPE[str(selfpath)][str(selftime_new)].append(G.EPE[str(selfpath)][str(selftime)][0]) #Добавляем самолет в массив слиятия 
					G.EPE[str(selfpath)].erase(t) #Убираем свой массив
					
					get_tree().get_first_node_in_group("Editor").update_point(str(selfpath),str(selftime_new)) #Обновить слитое событие
					get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new) #Окошко слитое событие
					self_delete_point() #Окошко наше пустое событие
			
			if (number + number_new) == 1: #Всего один самолет
				if number == 1:
					G.EPE[str(selfpath)][str(selftime)][0]["time"] = int(selftime_new)
					G.EPE[str(selfpath)][str(selftime_new)].append(G.EPE[str(selfpath)][str(selftime)][0]) #Добавляем самолет в массив слиятия 
					G.EPE[str(selfpath)].erase(t) #Убираем свой массив
					
					get_tree().get_first_node_in_group("Editor").update_point(str(selfpath),str(selftime_new)) #Обновить слитое событие
					get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new) #Окошко слитое событие
					self_delete_point() #Окошко наше пустое событие
				if number_new == 1:
					G.EPE[str(selfpath)].erase(t) #Убираем свой массив
					get_tree().get_first_node_in_group("Editor").open_window(selfpath,selftime_new)#Окошко слитое событие
					self_delete_point() #Окошко наше пустое событие
		
		if not G.EPE[str(selfpath)].has(str(selftime_new)): #Если события нет
			for plane in p[t]:
				plane["time"] = int(selftime_new)
			G.EPE[str(selfpath)][str(selftime_new)] =p[t]
			
			selftime = selftime_new
			name = str(selftime_new)
			
			G.EPE[str(selfpath)].erase(t) #Убираем свой массив
			opem_window()
	
	if event.is_action_pressed("mouse_click"):
		opem_window()
	
	if event.is_action_pressed("right_mouse_click"):
		self_delete_point()

