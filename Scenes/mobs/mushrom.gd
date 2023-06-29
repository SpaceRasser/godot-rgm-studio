extends CharacterBody2D

var stands = true
var destrination = Vector2()
#var velocity = Vector2()


func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(randf_range(pos.x - 10, pos.x + 10))
		
		
	
	
	
	
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _physics_process(delta):
#	velocity.y += gravity * delta
#	move_and_slide()



