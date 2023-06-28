extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var hp = 100
const max_hp = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	_set_start_hp(hp, max_hp)
	pass

func _set_start_hp(hp, max_hp):
	$HP_Bar.value = hp
	$HP_Bar.max_value = max_hp

func update_hp():
	$HP_Bar.value = hp


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() :
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("down", "up")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true;
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false;
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		if velocity.y == 0:
			anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y > 0:
		anim.play("fall")
	move_and_slide()
