extends Node2D


func _ready():
	$Sprite2D.hide()

@onready var Anim = $AnimationPlayer

func play():
	$Sign.play()
