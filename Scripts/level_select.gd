extends Control

func _input(event):
	if event.is_action_pressed("ESC"):
		G.change_scene("menu")


@onready var L = preload("res://Scenes/Level.tscn")

var levels = [1,2]

func _ready():
	for i in levels:
		var l = L.instantiate()
		l.number = i
		
		if G.there_levels.has(i):
			l.open = true
			print(G.there_levels)
		
		if G.there_levels_completed.has(i):
			l.completed = true
		$MarginContainer/GridContainer.add_child(l)
