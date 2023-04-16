extends VBoxContainer



func match_check(plane): #Проверка на совпадение side самолетов
	for i in %Planes.get_children():
		if i != plane:
			if i.side == plane.side:
				if i.path != plane.path or i.time != plane.time:
					return true
				else:
					return false
	return true


func delete_plane(plane): #Удалить самолет
	for i in %Planes.get_children():
		if i != plane:
			pass
		else:
			i.side = ""
			i.queue_free()
			$"../..".save_planes()
