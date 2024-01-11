extends CharacterBody3D


@onready var nav = $NavigationAgent3D
@onready var blood = $blood
@onready var l_wheel = $l_wheel
@onready var r_wheel = $r_wheel
@onready var flames = $flames
@onready var body = $body

#@onready var selector = $Area3D/selector
#@onready var area_3d = $area_sight


#@onready var armature = $armature
#@onready var spring_arm_pivot = $SpringArmPivot
#@onready var spring_arm = $SpringArmPivot/SpringArm3D
#@onready var anim_tree = $AnimationTree
#@onready var anim_player = $AnimationPlayer
#@onready var collision_shape_3d = $Area3D2/CollisionShape3D

#@onready var area_home = $area_home


#@onready var flash_light = $Armature/Skeleton3D/Head/flash_light


#@onready var player = get_node('main/player')

var speed = 3.5
const LERP_VAL = .15

var player_body = PlayerVariables.enemy_aim
var player_location = PlayerVariables.location
var in_range=false
var home = Vector3()
var b =0
var health=45
var spotted=false
#@onready var hit_box = $hit_box
var ammo=preload("res://scenes/pickup_ammo.tscn")
#var game=preload("res://scenes/main.tscn")

@onready var health_label = $health

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var name_label = $name
#@onready var game = $".."

var current_location = global_transform.origin
#var area_home = PlayerVariables.area_home


func _ready():
	scale=Vector3(.8,.8,.8)
	speed=speed+randi_range(-2,2)


	home = global_transform.origin
	#print("home: ", home)
	
	
func _process(delta):
	health_label.text=str(health)
	name_label.text=str(name)
	player_body = PlayerVariables.enemy_aim
	#look_at(player_location)
	
	if health<=0:
		body.transparency+=.05
		for child in body.get_children():
			child.transparency+=.1
			
		blood.visible=true
		b+=1
		if b>=50:
			var drop=ammo.instantiate()
			drop.position=position
			drop.position.y-=1
			get_node("../..").add_child(drop)
			PlayerVariables.kills+=1
			queue_free()
			b=0
			
		
func _physics_process(delta):
	if home.distance_to(PlayerVariables.location)<=50:
		spotted=true
		look_at(player_body)
	if home.distance_to(PlayerVariables.location)>=49:
		spotted=false
		look_at(home)
	#scale=Vector3(.05*health,.05*health,.05*health)
	#speed=health/15
	var player_origin = PlayerVariables.location

# you get the position of the enemy
	var enemy_origin = self.global_transform.origin

# when you subtract enemy from player, what you get is kind of like the _direction_ towards the player, which we will store in offset
	var to_player = player_origin - enemy_origin
	
	var to_home= home - enemy_origin
	#print(position.distance_to(PlayerVariables.location))
	#if position.distance_to(PlayerVariables.location)<5:
		#pass
	#if position.distance_to(PlayerVariables.location)>5 and position.distance_to(PlayerVariables.location)<30:
	


	#if position.distance_to(PlayerVariables.location) <= 50:
		#spotted=true
	#if position.distance_to(PlayerVariables.location) >= 49:
		#spotted=false
		
	#else:
		#pass
	if in_range==true:
		PlayerVariables.health-=1
		PlayerVariables.ouch=true
		
		#if scale!=Vector3(1.5,1.5,1.5):
			#scale+=Vector3(.5,.5,.5)
		#else:
			#scale=Vector3(1,1,1)
		
	#if in_range==false:
		#flames.visible=false
		
		#pass
	
	

	l_wheel.rotation.x-=speed/8
	r_wheel.rotation.x-=speed/8
	#print("distance: ", position.distance_to(PlayerVariables.location))
	
	#var offset = Vector3(randi_range(-4, 4),randi_range(-4, 4), randi_range(0, 0))
	
	
	current_location = global_transform.origin
	#var next_location = nav.get_next_path_position()
	if spotted==true:
		var new_velocity = (to_player).normalized() * speed 
		velocity = velocity.move_toward(new_velocity,.25)
	else:
		var new_velocity = (to_home).normalized() * speed 
		velocity = velocity.move_toward(new_velocity,.25)
	# Add a random offset to the direction vector
		#var new_velocity = (to_home).normalized() * speed
		#velocity = velocity.move_toward(new_velocity,.25)
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y-=2

	move_and_slide()

#func update_target_position(delta):
	#if position.distance_to(PlayerVariables.location) <= 30:
		#player_location = PlayerVariables.location
		#nav.set_target_position(player_location)
	#if position.distance_to(PlayerVariables.location) >= 29:
		#nav.set_target_position(home)
		# you get the position of the player
#func update_target_position():
	
		#print("spotted" )
		#player_location = PlayerVariables.location
		#pass
		#nav.set_target_position(PlayerVariables.location)
	
		#pass

# normalize offset so that it is a Vector of length 1
# multiply by our move speed and by delta
	#move_toward(offset.normalized() * speed * delta)


func _on_melee_body_entered(player_body):
	in_range=true
	flames.visible=true
	
	print("i got you, bitch!")
	
	await get_tree().create_timer(0.1).timeout
	PlayerVariables.ouch=false
	
	pass # Replace with function body.


func _on_melee_body_exited(player_body):
	in_range=false
	flames.visible=false
	PlayerVariables.ouch=false
	pass # Replace with function body.



