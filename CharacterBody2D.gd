extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle Jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("Jump_Animation")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Walk_Animation")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("Idle_Animation")

	move_and_slide()
	
	


func _on_area_2d_body_entered(body):
	$AnimationPlayer.play("Eat_Animation")
	if body.is_in_group("collectible"):
		body.Collect()
