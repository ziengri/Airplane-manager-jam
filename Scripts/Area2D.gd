extends Area2D

@export var side: int

func _on_body_entered(body):
	if body.side == side:
		body.queue_free()
	print("Удален")
	pass # Replace with function body.


func _on_area_entered(area):
	if area.get_parent().side == side:
		area.get_parent().queue_free()
	print("Удален")
	pass # Replace with function body.
