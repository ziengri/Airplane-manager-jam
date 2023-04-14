extends Area2D

@export var side: int



func _on_area_entered(area: Area2D):
	if area.get_parent().side == side:
		area.queue_free()
	print("Удален")
	pass # Replace with function body.

