extends CharacterBody3D

@onready var nav = $NavigationAgent3D
@onready var blood = $blood

#@onready var selector = $Area3D/selector
#@onready var area_3d = $area_sight

var speed = 8
const LERP_VAL = .01
@onready var name_label = $name

var player_body = PlayerVariables.enemy_aim
var player_location = PlayerVariables.location
var in_range=false
var home = Vector3()
var b =0
var health=15
var l=false
var t=randi_range(1,10)
var tt=randi_range(1,10)
var spotted=false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var current_location = global_transform.origin
#var area_home = PlayerVariables.area_home


func _ready():
	speed=speed+randi_range(-2,2)
	
	position=PlayerVariables.last_crystal_position+Vector3(randf_range(20,50),1,randf_range(20,50))
	
	#print("i am alive")
	name="humanoid"
	home = global_transform.origin
	#print("home: ", home)
	print("lcp: ", PlayerVariables.last_crystal_position)
func _process(delta):
	name_label.text=str(name)
	player_body = PlayerVariables.enemy_aim
	#look_at(player_location)
	
	if health<=0:
		blood.visible=true
		b+=1
		if b>=50:
			PlayerVariables.kills+=1
			queue_free()
			b=0
			
			
			
		
func _physics_process(delta):
	var player_origin = PlayerVariables.location

# you get the position of the enemy
	var enemy_origin = self.global_transform.origin

# when you subtract enemy from player, what you get is kind of like the _direction_ towards the player, which we will store in offset
	var to_player = player_origin - enemy_origin
	#print(position.distance_to(PlayerVariables.location))
	#if position.distance_to(PlayerVariables.location)<5:
		#pass
	#if position.distance_to(PlayerVariables.location)>5 and position.distance_to(PlayerVariables.location)<30:
	look_at(player_body)
	if position.distance_to(PlayerVariables.location) <= 500:
		spotted=true
	if position.distance_to(PlayerVariables.location) >= 499:
		spotted=false
	#else:
		#pass
	if in_range==true:
		
		
		PlayerVariables.health-=1
		PlayerVariables.ouch=true
		print("i got you, bitch!")
		
		#if scale!=Vector3(1.5,1.5,1.5):
			#scale+=Vector3(.5,.5,.5)
		#else:
			#scale=Vector3(1,1,1)
		
	if in_range==false:
		pass
	
	var r=randi_range(1,4)
	#print("distance: ", position.distance_to(PlayerVariables.location))
	
	current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (to_player).normalized() * (speed + r)
	# Add a random offset to the direction vector
	
	
	velocity = velocity.move_toward(new_velocity,.25)


	#sway code
	if l==true:
		t+=1
		if t>10:
			position.x=lerpf(position.x,position.x+randi_range(-2,2),.4)
			position.z=lerpf(position.z,position.z+randi_range(-2,2),.4)
			#rotation_degrees.z=lerp(rad_to_deg(0),rad_to_deg(50),.4)
			#print("moving on up" )
			l=false
			t=0
		
	if l==false:
		tt+=1
		if tt>10:
			position.x=lerpf(position.x,position.x-randi_range(-2,2),.4)
			position.z=lerpf(position.z,position.z-randi_range(-2,2),.4)
			l=true
			#print("moving on down")
			tt=0
			
	position.y+=.1
	#print("t: ", t)
	#print("tt: ", tt)
	#print(new_velocity)
	
	
	
	move_and_slide()


		#print("going home" )
		#nav.set_target_position(home)

	
