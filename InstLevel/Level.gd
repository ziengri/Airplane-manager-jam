extends Node2D


func _input(event):
	if event.is_action_pressed("ESC"):
		if get_tree().get_current_scene().name == "LevelEditor":
			Au.MenuSoundPlay()
			get_tree().get_current_scene().remove_level()
		if get_tree().get_current_scene().name == "World":
			Au.MenuSoundPlay()
			G.change_scene("menu")
#	else:
#		Au.MenuSoundPlay()
#		G.change_scene("menu")

@onready var PATH: PackedScene = preload("res://Scenes/path.tscn")
@onready var passenger : PackedScene = preload("res://Scenes/Planes/base_airplane.tscn")
@onready var maize : PackedScene = preload("res://Scenes/Planes/Kukuruznik.tscn")
@onready var fighter : PackedScene = preload("res://Scenes/Planes/Istrebitel.tscn")
@onready var сargo : PackedScene = preload("res://Scenes/Planes/HeavyPlane.tscn")

@onready var paths : Array #= [$Paths/Path, $Paths/Path2]
@onready var Losing = $Ui/Losing
@onready var Win = $Ui/Win
@onready var TimeToWin = $Ui/Label
@onready var LeftArea = $LeftAreaSwitcher
@onready var RightArea = $RightAreaSwitcher

@onready var level_timer: Timer = $Timer
@onready var before_timer: Timer = $timer_before_create

var level_path = Fs.selected_level_file["path"]
var level_time = Fs.selected_level_file["time"]
var LEVEL = Fs.selected_level_file

func _ready():
	LeftArea.connect("body_entered",area_body_entered)
	LeftArea.connect("body_exited",area_body_exited)
	RightArea.connect("body_entered",area_body_entered)
	RightArea.connect("body_exited",area_body_exited)
	
	preready()
	level_timer.start(level_time)
	START()

var planes: Array[Dictionary] 

func preready():
	print("\nLEVEL NAME: ",Fs.selected_level_file["name"])
	print("LEVEL TIME: ",Fs.selected_level_file["time"])
	print("LEVEL PATH: ",Fs.selected_level_file["path"])
	print("LEVEL EVENTS: ",Fs.selected_level_file["events"])
	add_path()
	
#	for path in Fs.selected_level_file["events"]:
#		for second in Fs.selected_level_file["events"][path]:
#			for plane in Fs.selected_level_file["events"][path][second]:
#				if plane["side"] == "Right":
#					plane["side"] = -1
#				else:
#					plane["side"] = 1
#				planes.push_back(plane)
#	#print("\n\n\n",planes)


func add_path():
	var pos_path = Vector2(0,50)
	if level_path < 5:
		pos_path.y += 30
	if level_path < 4:
		pos_path.y += 10
	if level_path < 3:
		pos_path.y += 40
	
	for path_n in range(1,level_path+1):
		var new_path = PATH.instantiate()
		pos_path.y += 100
		new_path.position = pos_path
		$Paths.add_child(new_path)
	
	for path in $Paths.get_children():
		paths.push_back(path)



func _physics_process(_delta):
	if get_tree().get_current_scene().name == "World":
		TimeToWin.text = str(int(level_timer.time_left))
	if get_tree().get_current_scene().name == "LevelEditor":
		TimeToWin.text = str(int(level_time-level_timer.time_left))+"/"+str(int(level_time))



func START():
	for path in Fs.selected_level_file["events"]:
			var timer_new = Timer.new() #Создать таймер
			timer_new.name = str("timer_"+path)
			add_child(timer_new)
			
			START_CREATED(Fs.selected_level_file["events"][path],path) #Передать информацию о пути в аргументу функциии создания


func START_CREATED(Events,Path):
	for second in Events:
		#print("начали ",second," path ",Path)
		if int(second) == 0:
			CREATED(Events[second])
			#print("continue ",second," path ",Path)
			print("create ",second," path ",Path)
			continue
		get_node(str("timer_"+Path)).start(abs(int(second)-(level_time-level_timer.time_left)))
		await get_node(str("timer_"+Path)).timeout
		#print("create ",second," path ",Path)
		CREATED(Events[second])


func CREATED(arr_planes):
	for plane in arr_planes:
		create_airplane(plane["path"],plane["side"],plane["type"])
		#print("ПОЛЕТЕЕЕЕЕЕЕЕЕЕЕЕЕЕЛ  ",plane["time"])


func create_airplane(pathNum : int, _side: String, type : String):
	var path : Line2D = paths[pathNum-1]
	
	var new_plane : BaseAirplane = get(type).instantiate()
	var side : int
	
	if _side == "Right":
		side = -1
	if _side == "Left":
		side = 1
	
	if side == 1:
		path.left_icon.Anim.play("Warning")
	else:
		path.right_icon.Anim.play("Warning")

	new_plane.side = side
	new_plane.path = path
	
	new_plane.position.x = path.points[1 if side==-1 else 0].x + (400*(side*-1))
	new_plane.position.y = path.position.y
	
	self.get_node("Planes").add_child(new_plane)


func losing_editor():
	get_tree().paused = true
	$Ui/LosingEditor.show()


func losing():
	
	get_tree().paused = true
	#$Paths.hide()
	
	TimeToWin.hide()
	for i in get_node("Planes").get_children():
		#i.queue_free()
		pass
	
	#Показать проигрыш
	Losing.show()
	Au.LosePlay()


func win():
	#Уровень засчитывается пройденным
	if not G.there_levels_completed.has(G.selected_lvl):
		G.there_levels_completed.push_back(G.selected_lvl)
	
	#Открывается следующий уровень
	if G.selected_lvl != 3:
		G.selected_lvl = G.selected_lvl+1
		if not G.there_levels.has(G.selected_lvl):
			#print(G.there_levels.has(G.selected_lvl))
			G.there_levels.push_back(G.selected_lvl)
	
	get_tree().paused = true
	$Paths.hide()
	TimeToWin.hide()
	for i in get_node("Planes").get_children():
		i.queue_free()
		pass
	
	#Показать победу
	Win.show()
	Au.WinPlay()
	Fs.SAVE()


func area_body_entered(body) -> void:
	change_colis(body)


func area_body_exited(body) -> void:
	delete(body)


func change_colis(body):
	if body.can_colide:
		body.can_colide = false
	else:
		body.can_colide = true


func delete(body):
	if not body.can_colide:
		body.queue_free()


func _on_timer_timeout():
	if get_tree().get_current_scene().name == "World":
		win()
	if get_tree().get_current_scene().name == "LevelEditor":
		get_tree().get_current_scene().remove_level()
	
