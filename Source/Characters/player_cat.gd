extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)
# parameters/Idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


func _ready():
	_update_animation_paramters(starting_direction)

func _physics_process(_delta):
	var Input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	_update_animation_paramters(Input_direction)
	velocity = Input_direction * move_speed
	move_and_slide()
	_pick_new_state()

func _update_animation_paramters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func _pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
