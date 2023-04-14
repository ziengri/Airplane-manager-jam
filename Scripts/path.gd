extends Line2D

func _ready():
	self.self_modulate=Color(1,1,1,0.8)

@onready var left_icon = $Mark1
@onready var right_icon = $Mark2



func _on_area_2d_mouse_entered() -> void:
	G.selected_path = self
	if G.selected_airplane != null and G.selected_airplane.path != self:
		self.self_modulate=Color(0,1,0,0.5)


func _on_area_2d_mouse_exited() -> void:
	G.selected_path = null
	self.self_modulate=Color(1,1,1,0.8)


func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_released("mouse_click"):
		if G.selected_airplane != null:
			G.selected_airplane.Sprite.material.set('shader_parameter/line_thickness',0)
			G.selected_airplane.Sprite.material.set('shader_parameter/line_color',Color.BLACK)
		
			G.selected_airplane.path=self
			G.selected_airplane = null
			Au.PlanePlay()
			
			self.self_modulate=Color(1,1,1,0.8)

