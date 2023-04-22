extends Node2D

func _input(event):
	if event.is_action_pressed("ESC"):
		Au.MenuSoundPlay()
		G.change_scene("menu")

@onready var б = preload("res://Scenes/Planes/base_airplane.tscn")

@onready var к = preload("res://Scenes/Planes/Kukuruznik.tscn")
@onready var и = preload("res://Scenes/Planes/Istrebitel.tscn")
@onready var т = preload("res://Scenes/Planes/HeavyPlane.tscn")


@onready var mark = preload("res://Scenes/Mark.tscn")
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var paths : Array #= [$Paths/Path, $Paths/Path2]
@onready var Losing = $CanvasLayer/Losing
@onready var Win = $CanvasLayer/Win
@onready var TimeToWin = $CanvasLayer/Label




func _ready():
	for i in $Paths.get_children():
		paths.push_back(i)
	anim_player.play(str(G.selected_lvl))


func _physics_process(_delta):
	TimeToWin.text = str(anim_player.current_animation_length-int(anim_player.current_animation_position))
#	print(int(anim_player.current_animation_position))




func create_airplane_LEFT(pathNum : int,type : String):
	var path : Line2D = paths[pathNum]
	
	var new_plane : BaseAirplane = get(type).instantiate()
	
	path.left_icon.Anim.play("Warning")
	
	new_plane.side = 1
	new_plane.path = path
	
	new_plane.position.x = path.points[0].x - 400
	new_plane.position.y = path.position.y
	
	self.get_node("Planes").add_child(new_plane)


func create_airplane_RIGHT(pathNum : int,type : String):
	var path : Line2D = paths[pathNum]
	
	var new_plane : BaseAirplane = get(type).instantiate()
	
	path.right_icon.Anim.play("Warning")
	# Blyat, mne otoiti nado, minut cherez 10 budu
	new_plane.side = -1
	new_plane.path = path
	
	new_plane.position.x = path.points[1].x + 400
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
	G.WinPlay()
	Fs.SAVE()










func _on_left_area_switcher_body_entered(body) -> void:
	change_colis(body)

func _on_right_area_switcher_body_entered(body) -> void:
	change_colis(body)


func _on_left_area_switcher_body_exited(body) -> void:
	delete(body)

func _on_right_area_switcher_body_exited(body) -> void:
	delete(body)


func change_colis(body):
	if body.can_colide:
		body.can_colide = false
	else:
		body.can_colide = true


func delete(body):
	if not body.can_colide:
		body.queue_free()

