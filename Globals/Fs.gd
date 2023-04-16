extends Node


@onready var external_levels: Dictionary #Переменная подгруженных файлов
var selected_level_file: Dictionary  #Переменая выбраного уровня

func _ready():
	get_external_levels()
	if FileAccess.file_exists("user://save_game.txt"):
		var load_file = loader()
		G.there_levels = load_file["Открытые"]
		G.there_levels_completed = load_file["Пройденные"]


func saver(content):
	var file = FileAccess.open("user://save_game.txt", FileAccess.WRITE)#FileAccess.open_encrypted_with_pass("user://save_game.txt", FileAccess.WRITE, "Катслик")
	file.store_var(content)

func loader():
	var file = FileAccess.open("user://save_game.txt", FileAccess.READ)#FileAccess.open_encrypted_with_pass("user://save_game.txt", FileAccess.READ, "Катслик")
	var content = file.get_var()
	return content



#Cхранение уровней
func SAVE():
	var save_file: Dictionary
	save_file["Открытые"] = G.there_levels
	save_file["Пройденные"] = G.there_levels_completed
	saver(save_file)

#Сохранения настроек
func SAVE_OPT():
	pass


func get_external_levels()->void:
	if DirAccess.dir_exists_absolute("user://levels"):
		var dir = DirAccess.open("user://levels")
		for fileName in dir.get_files():
			var level = FileAccess.open("user://levels/"+fileName,FileAccess.READ)
			var levelContent = level.get_var()
			external_levels[levelContent["name"]] = levelContent
	else:
		DirAccess.make_dir_absolute("user://levels")
	#print(external_levels)
