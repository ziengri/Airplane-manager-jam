extends HBoxContainer

@onready var TimePlane = $TimePlane
@onready var PathePlane = $Path
@onready var SidePlane = $Side
@onready var TypePlane = $Type

var time = 0
var type
var side
var path

var NewPlane

func _ready():
	TimePlane.text = str(time)
	for i in range(G.selected_level_file["path"]):
		PathePlane.add_item(str(i+1))
	PathePlane.select(-1)
	

func _on_path_item_selected(index):
	path = PathePlane.get_item_text(index)
	assemble_plane()
	#save_plane()



func _on_side_item_selected(index):
	side = SidePlane.get_item_text(index)
	assemble_plane()
	#save_plane()



func _on_type_item_selected(index):
	type = TypePlane.get_item_text(index)
	assemble_plane()
	#save_plane()

func assemble_plane():
	NewPlane = {"path":path,"side":side,"type":type,"time":time}

func get_assemb_plane():
	if path != null and side != null:
		assemble_plane()
		return NewPlane
	else:
		return null

#func save_plane():
#	var PlaneSave = {"path":path,"side":side,"type":type,"time":time}
#
#	G.selected_level_file["Planes"].append(PlaneSave)
#
#	var file = FileAccess.open("user://levels/"+G.selected_level_file["name"]+".txt", FileAccess.WRITE)
#	file.store_var(G.selected_level_file)
#	print(G.selected_level_file)

func _on_check_box_pressed():
	queue_free()








func _on_time_plane_text_changed(new_text):
	print("changed: ",$TimePlane.text)









func _on_time_plane_focus_entered():
	print("changed: ",$TimePlane.text)


func _on_time_plane_focus_exited():
	if TimePlane.text.is_valid_int() and int(TimePlane.text) <= G.selected_level_file["time"] and int(TimePlane.text) >= 0:
		time = TimePlane.text
	else:
		#if TimePlane.text != time:
			#queue_free()
		TimePlane.text = time
