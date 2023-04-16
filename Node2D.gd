extends Node2D

func _ready():
	var dic: Dictionary = {
	"1": {"42": [{"path":1,"side":"Left","type":"passenger","time":42},{"path":1,"side":"Right","type":"maize","time":42}]},
	"2": {"18": [{"path":2,"side":"Right","type":"fighter","time":18}]},
	"3": {"12": [{"path":3,"side":"Right","type":"сargo","time":12}]},
	"4": {"32": [{"path":4,"side":"Left","type":"сargo","time":32}]},
	"5": {},
	}
	dic["1"].erase("42")
	print(dic)
