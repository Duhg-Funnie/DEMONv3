extends CharacterBody3D

@onready var head = $head
@onready var enemy_aim = $enemy_aim

var speed = 7.0
const JUMP_VELOCITY = 10
const mouse_sens = 0.2
var score=0
var jump=0
var sprinting_speed=15

var can_sprint=false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	if Input.is_action_pressed("sprint") and can_sprint==true:
		PlayerVariables.stamina-=.2
		speed=15
	else:
		speed=8

func _process(delta):
	#if position.y<=
	PlayerVariables.location = self.global_transform.origin
	PlayerVariables.enemy_aim = enemy_aim.global_transform.origin
	PlayerVariables.body = self
	#PlayerVariables.current_speed=current_speed

func _physics_process(delta):
	
	if position.y<-1:
		PlayerVariables.ouch=true
		PlayerVariables.health-=1
	else:
		PlayerVariables.ouch=false
	
	if is_on_floor():
		can_sprint=true
		if Input.get_vector("left", "right", "up", "down"):
			PlayerVariables.stamina-=.1
		#jump=0	
	
	# Add the gravity.
	if not is_on_floor():
		
		velocity.y -= gravity * delta
		#jump+=1
		#print("WHOA : ", jump)
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		PlayerVariables.stamina-=.4
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed 
		velocity.z = direction.z * speed 
	else:
		
		#score=score+jump
		#print("score: ", score)
		
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
	#
	#connect("wet")

#func _on_bullet_time_area_body_entered(body):
	#if body.name=="humanoid":
		#Engine.time_scale=.5
	#pass # Replace with function body.


#func _on_bullet_time_area_body_exited(body):
	#if body.name=="humanoid":
		#Engine.time_scale=1
	
	#pass # Replace with function body.

