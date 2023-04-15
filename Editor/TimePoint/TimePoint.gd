extends Panel

@onready var Lavel = $Label

var selftime: int 
var path

func _ready():
	print(selftime," ",G.EPE[str(selftime)].size())
	
	if G.EPE[str(selftime)].size() == 2:
		Lavel.text = "><"
	elif G.EPE[str(selftime)].size() == 0:
		Lavel.text = ""
	else:
		match G.EPE[str(selftime)][0]["side"]:
			"Right":
				Lavel.text = "<"
			"Left":
				Lavel.text = ">"

