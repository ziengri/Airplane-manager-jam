extends Node


@onready var menu = preload("res://Scenes/menu.tscn")
@onready var level_selection = preload("res://Scenes/level_select.tscn")
@onready var level_edit_menu = preload("res://Editor/MenuEditor/menu_editor.tscn")

@onready var level_editor = preload("res://Editor/LevelEditor/level_editor.tscn")
@onready var game1 = preload("res://Levels/world.tscn")
@onready var game2 = preload("res://Levels/world2.tscn")
@onready var game3 = preload("res://Levels/world3.tscn")
@onready var game4 = preload("res://Levels/world4.tscn")




var selected_airplane: CharacterBody2D
var selected_level_file: Dictionary #Переменая выбраного уровня
var selected_path
var selected_lvl
var there_levels: Array = [1,2,3]
var there_levels_completed: Array = [1,2,3]


func change_scene(type):
	get_tree().change_scene_to_packed(get(type))

