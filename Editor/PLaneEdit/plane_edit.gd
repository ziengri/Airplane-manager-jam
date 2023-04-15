extends HBoxContainer

@onready var TimePlane = $TimePlane
@onready var PathePlane = $Path
@onready var SidePlane = $Side
@onready var TypePlane = $Type
@onready var Marker = $Control/CheckBox2


var time: int
var type: String
var side: int
var path: int


var NewPlane: Dictionary #Самолет

func _ready():
	TimePlane.text = str(time)
	
	for i in range(G.selected_level_file["path"]):
		PathePlane.add_item(str(i+1))
	
	PathePlane.select(path-1)


#Собрать самолет
func assemble_plane():
	NewPlane = {"path":path,"side":side,"type":type,"time":time}

#Передать собранный самолет либо указать на неккоректность
func get_assemb_plane():
	if path == null and side == null:
		Marker.color = Color.RED
		return null
	if get_parent().get_parent().get_parent().match_check(self) != false:
		assemble_plane()
		Marker.color = Color.GREEN
		return NewPlane
	else:
		Marker.color = Color.RED
		return null



#ПУТЬ
func _on_path_item_selected(index):
	path = PathePlane.get_item_text(index)
	assemble_plane()

#СТОРОНА
func _on_side_item_selected(index):
	side = SidePlane.get_item_text(index)
	assemble_plane()

#ТИП
func _on_type_item_selected(index):
	type = TypePlane.get_item_text(index)
	assemble_plane()




#Удалить самолет
func _on_check_box_pressed():
	get_parent().get_parent().get_parent().delete_planes(self)




#Изменения времени самолета
func _on_time_plane_focus_exited():
	if TimePlane.text.is_valid_int() and int(TimePlane.text) <= G.selected_level_file["time"] and int(TimePlane.text) >= 0:
		time = TimePlane.text
	else:
		#if TimePlane.text != time:
			#queue_free()
		TimePlane.text = time
