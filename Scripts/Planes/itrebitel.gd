extends BaseAirplane

func _ready():
	HORIZONTAL_SPEED = 160
	_preready()
	
	

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int)->void:
	pass
