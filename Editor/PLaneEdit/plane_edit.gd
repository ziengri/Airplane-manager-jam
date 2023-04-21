extends HBoxContainer

@onready var TimePlane = $TimePlane
@onready var PathePlane = $Path
@onready var SidePlane = $Side
@onready var TypePlane = $Type
@onready var Marker = $Control/CheckBox2


var time: int
var type: String
var side: String
var path: int


var NewPlane: Dictionary #Самолет


func _ready():
	TimePlane.text = str(time)
	
	for i in range(Fs.selected_level_file["path"]):
		PathePlane.add_item(str(i+1))
	
	PathePlane.select(path-1)


func inf_up(): #Функция для того чтобы отобразить сущуствующий самолет в событии при открытии окошка
	Marker.color = Color.GREEN
	match side:
		"Right":
			SidePlane.select(0)
		"Left":
			SidePlane.select(1)
	
	for index in TypePlane.item_count:
		if TypePlane.get_item_text(index) == type:
			TypePlane.select(index)
			return


#Собрать самолет
func assemble_plane():
	NewPlane = {"path":path,"side":side,"type":type,"time":time}
	Marker.color = Color.GREEN


#Передать собранный самолет либо указать на неккоректность
func get_assemb_plane():
	if type == "" or side == "":
		mark()
		return null
	
	if get_parent().match_check(self) != false:  #Передать               
		assemble_plane()
		return NewPlane
	
	else:
		mark()
		return null


func mark():
	Marker.color = Color.RED

#ПУТЬ
func _on_path_item_selected(index):
	path = int(PathePlane.get_item_text(index))
	#assemble_plane()

#СТОРОНА
func _on_side_item_selected(index):
	side = SidePlane.get_item_text(index)
	#assemble_plane()

#ТИП
func _on_type_item_selected(index):
	type = TypePlane.get_item_text(index)
	#assemble_plane()




#Удалить самолет
func _on_check_box_pressed():
	get_parent().delete_plane(self)




#Изменения времени самолета
func _on_time_plane_focus_exited():
	if TimePlane.text.is_valid_int() and int(TimePlane.text) <= Fs.selected_level_file["time"] and int(TimePlane.text) >= 0:
		time = int(TimePlane.text)
	else:
		TimePlane.text = str(time)

