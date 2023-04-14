extends Panel

@export var number: int
@export var open: bool
@export var completed: bool

func _ready():
	$Label.text = str(number)
	if not open:
		$Label.modulate.a = 0.2
	if completed:
		$Label.modulate.r = 0.5
	if open:
		$Label.modulate.a = 0.93

func _on_gui_input(event):
	if event.is_action_pressed("mouse_click") and open:
		Au.MenuSoundStop()
		G.selected_lvl = number
		G.change_scene("game"+str(number))
