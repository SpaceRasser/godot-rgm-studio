extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
const hp = 20
var max_hp = 100

func _ready():
	_set_start_hp(hp, max_hp)
	pass

func _set_start_hp(hp, max_hp):
	$HP_Bar.value = hp
	$HP_Bar.max_value = max_hp

func update_hp():
	$HP_Bar.value = hp

func _physics_process(delta):
	#Gravity for Frog
	velocity.y += gravity * delta
	if chase == true:
		get_node("AnimatedSprite2D").play("run")
		player = get_node("../../player/player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "player":
		chase = false
