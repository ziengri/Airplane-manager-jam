extends Node


@onready var menu = preload("res://Scenes/menu.tscn")
@onready var level_selection = preload("res://Scenes/level_select.tscn")
@onready var level_edit_menu = preload("res://Editor/MenuEditor/menu_editor.tscn")
@onready var level_inst = preload("res://InstLevel/world.tscn")

@onready var level_editor = preload("res://Editor/LevelEditor/level_editor.tscn")
@onready var game1 = preload("res://Levels/world.tscn")
@onready var game2 = preload("res://Levels/world2.tscn")
@onready var game3 = preload("res://Levels/world3.tscn")
@onready var game4 = preload("res://Levels/world4.tscn")





#var selected_level_file: Dictionary
var EPE: Dictionary 
#= {
#	"1": {"42": [{"path":1,"side":"Left","type":"passenger","time":42},{"path":1,"side":"Right","type":"maize","time":42}],},
#	"2": {"18": [{"path":2,"side":"Right","type":"fighter","time":18}]},
#	"3": {"12": [{"path":3,"side":"Right","type":"сargo","time":12}]},
#	"4": {"32": [{"path":4,"side":"Left","type":"сargo","time":32}]},
#	"5": {},
#	}



var selected_airplane: CharacterBody2D
var selected_path 
var selected_lvl: int #obsolete
var there_levels: Array = [1]
var there_levels_completed: Array = []


func change_scene(type):
	get_tree().change_scene_to_packed(get(type))

