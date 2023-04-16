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
	print(selftime)
	print(selfpath)
	#G.EPE[str(selfpath)][str(selftime)] = []
#	print(dic["1"].erase("42"))
	get_tree().get_first_node_in_group("Editor").close_window(selfpath,selftime)
	p.erase(t)
	print(G.EPE)
	
	queue_free()


func _on_gui_input(event):  #Нажатия на точку
	if event.is_action_pressed("mouse_click"):
		opem_window()
	
	if event.is_action_pressed("right_mouse_click"):
		self_delete_point()
