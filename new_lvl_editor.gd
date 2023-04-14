extends Node2D


func _input(event):
	if event.is_action_pressed("ESC"):
		Au.MenuSoundPlay()
		G.change_scene("menu")

@onready var б = preload("res://Scenes/Planes/base_airplane.tscn")

@onready var к = preload("res://Scenes/Planes/Кукурузник.tscn")
@onready var и = preload("res://Scenes/Planes/Истребитель.tscn")
@onready var т = preload("res://Scenes/Planes/Тяжеловес.tscn")


@onready var mark = preload("res://Scenes/Mark.tscn")
#@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var paths : Array #= [$Paths/Path, $Paths/Path2]
@onready var Losing = $CanvasLayer/Losing
@onready var Win = $CanvasLayer/Win
@onready var TimeToWin = $CanvasLayer/Label
@onready var LeftArea = $LeftAreaSwitcher
@onready var RightArea = $RightAreaSwitcher

var level_time:int = 15
@onready var level_timer:Timer =$Timer
@onready var before_timer:Timer = $timer_before_create

var level :Array[Dictionary] = [
		{"path":1,"side":1,"type":"к","time":2},
		{"path":1,"side":-1,"type":"к","time":2},
		{"path":3,"side":1,"type":"б","time":10},
		{"path":3,"side":1,"type":"и","time":12}
	]

func _ready():
	LeftArea.connect("body_entered",Larea_body_entered)
	LeftArea.connect("body_exited",Larea_body_exited)
	RightArea.connect("body_entered",Rarea_body_entered)
	RightArea.connect("body_exited",Rarea_body_exited)
	preready()
	level_timer.start(level_time)
	for i in $Paths.get_children():
		paths.push_back(i)
	start_level(level)

func preready():
	level_time = G.selected_level_file["time"]
	print("\nTIME LEVEL: ",G.selected_level_file["time"])
	print("LEVEL: ",G.selected_level_file)


func _physics_process(_delta):
	TimeToWin.text = str(int(level_time-level_timer.time_left))


func start_level(_level:Array[Dictionary])->void:
	for plane in _level:
		#print(abs(plane["time"]-(level_time-level_timer.time_left)))
		before_timer.start(abs(plane["time"]-(level_time-level_timer.time_left)))
		await before_timer.timeout
		create_airplane(plane["path"],plane["side"],plane["type"])


func create_airplane(pathNum : int,side:int,type : String):
	var path : Line2D = paths[pathNum]
	
	var new_plane : BaseAirplane = get(type).instantiate()
	
	path.left_icon.Anim.play("Warning")
	
	new_plane.side = side
	new_plane.path = path
	
	new_plane.position.x = path.points[1 if side==-1 else 0].x + (400*(side*-1))
	new_plane.position.y = path.position.y
	
	self.get_node("Planes").add_child(new_plane)






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






func Rarea_body_entered(body) -> void:
	change_colis(body)


func Rarea_body_exited(body) -> void:
	delete(body)



func Larea_body_entered(body) -> void:
	change_colis(body)


func Larea_body_exited(body) -> void:
	delete(body)


func change_colis(body):
	if body.can_colide:
		body.can_colide = false
	else:
		body.can_colide = true


func delete(body):
	if not body.can_colide:
		body.queue_free()
