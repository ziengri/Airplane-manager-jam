extends CharacterBody2D
class_name BaseAirplane


@export var path:Line2D =null
@export var side: int

var acceleration = 80
@export var VERTICAL_SPEED: int = 100
@export var HORIZONTAL_SPEED: int = 80
@export var HITBOX_SIZE : float = 1

@onready var DetectionArea : Area2D = $InteractionArea
@onready var HitboxArea : Area2D = $HitboxArea
@onready var Sprite : Sprite2D

var can_colide=false

func _ready() -> void:
	_preready()

func _preready()->void:
	self.Sprite = $Sprite2D
	self.DetectionArea.input_event.connect(_on_area_2d_input_event)
	self.HitboxArea.area_entered.connect(_on_hitbox_area_entered)
	self.Sprite.material = Sprite.material.duplicate()
	self.set_scale(Vector2(self.scale.x*side*-1,self.scale.y))

func _physics_process(_delta: float) -> void:
	var direction =path.global_position.y - self.global_position.y  
	velocity.x= HORIZONTAL_SPEED*side
	velocity.y=move_toward(velocity.y,direction,VERTICAL_SPEED)
	move_and_slide()


func _input(event) -> void:
	if event.is_action_released("mouse_click") and G.selected_path == null:
		Sprite.material.set('shader_parameter/line_thickness',0)
		Sprite.material.set('shader_parameter/line_color',Color.BLACK)
		G.selected_airplane = null

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int)->void:
	if event.is_action_pressed("mouse_click"):
		Sprite.material.set('shader_parameter/line_thickness',3)
		Sprite.material.set('shader_parameter/line_color',Color(0,1,0,0.5))
		G.selected_airplane = self


func _on_hitbox_area_entered(_area):
	
	if can_colide:
		if get_tree().get_current_scene().name == "World":
			get_tree().get_first_node_in_group("World").losing()
		elif get_tree().get_current_scene().name == "LevelEditor":
			get_tree().get_first_node_in_group("World").losing_editor()

