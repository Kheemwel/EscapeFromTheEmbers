extends KinematicBody2D

const ACCELERATION = 500
const FRICTION = 500
var MAX_SPEED = 50

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footstepSound = $FootStepSound
onready var firehurtSound = $FireHurtSound

func _ready():
	animationTree.active = true
	
	var MapRect = get_parent().get_node("Floors").get_used_rect()
	var MapCellSize = get_parent().get_node("Floors").cell_size
	
	$Camera2D.limit_left = MapRect.position.x * MapCellSize.x
	$Camera2D.limit_right = MapRect.end.x * MapCellSize.x
	
	$Camera2D.limit_top = MapRect.position.y * MapCellSize.y
	$Camera2D.limit_bottom = MapRect.end.y * MapCellSize.y

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if Input.is_action_pressed("run"):
		MAX_SPEED = 100
		footstepSound.pitch_scale = 1.25
		
		if input_vector != Vector2.ZERO:
			animationTree.set("parameters/Walk/blend_position", input_vector)
			animationTree.set("parameters/Run/blend_position", input_vector)
			animationState.travel("Run")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			if footstepSound.playing == false:
				footstepSound.playing = true
		else:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if footstepSound.playing:
				footstepSound.playing = false
	else:
		MAX_SPEED = 50
		footstepSound.pitch_scale = 1
		
		if input_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", input_vector)
			animationTree.set("parameters/Walk/blend_position", input_vector)
			animationState.travel("Walk")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			if footstepSound.playing == false:
				footstepSound.playing = true
		else:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if footstepSound.playing:
				footstepSound.playing = false
	
	velocity = move_and_slide(velocity)
	
	if $"/root/GlobalScript".is_player_burning:
		if firehurtSound.playing == false:
			firehurtSound.play()
	else:
		if firehurtSound.playing:
			firehurtSound.stop()
