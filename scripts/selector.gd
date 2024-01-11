extends RayCast3D


#@onready var stone_label = $"../../../player_gui/stone"

@onready var stone = $"../../player_gui/ui_inventory/stone"

@onready var l_arm = $"../l_arm"
@onready var r_arm = $"../r_arm"
#@onready var l_empty = $"../l_arm/l_empty"
@onready var l_pickaxe = $"../l_arm/l_pickaxe"
#@onready var r_empty = $"../r_arm/r_empty"
#@onready var r_pickaxe = $"../r_arm/r_pickaxe"
@onready var head = $".."
@onready var r_pistol = $"../r_arm/r_pistol"
#@onready var l_pistol = $"../l_arm/l_pistol"
@onready var r_bam = $"../r_arm/r_pistol/r_bam"
#@onready var l_bam = $"../l_arm/l_pistol/l_bam"
@onready var ouch = $"../../player_gui/ui_screen/ouch"
@onready var pistol_loaded = $"../../player_gui/ui_inventory/pistol_loaded"
@onready var pistol_reserve = $"../../player_gui/ui_inventory/pistol_reserve"

@onready var reload_label = $"../../RELOAD"



@onready var selector = $"."


@onready var L_interact = $"../../player_gui/ui_interact/L_interact"
@onready var R_interact = $"../../player_gui/ui_interact/R_interact"
@onready var flash_light = $"../flash_light"
@onready var spring_arm_3d = $"../SpringArm3D"
@onready var camera_3d = $"../SpringArm3D/Camera3D"

var sfx_jump_2 = preload("res://sounds/sfx_jump_2.wav")
var sfx_dash = preload("res://sounds/sfx_dash.wav")
var sfx_slide = preload("res://sounds/sfx_slide.wav")


var swap=false

var current_speed = 7.0
const walking_speed = 7.0
const sprinting_speed = 18.0
const crouching_speed = 5.0

const jump_velocity = 7.0
#const big_jump_velocity = 16



var just_dashed=false
var dc=0
var jump=false
var lerp_speed = 6.0
var jump_count =0
var direction = Vector3.ZERO

var crouching_depth = 0.3


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



var is_entered = false
var c_timer = 0
var c=0
var cc=0
var t=0
var tt=0
#-----#
#if not audio_stream_jump.is_playing():
#	audio_stream_jump.stream = sfx_jump_2
#	audio_stream_jump.play()
#				
#		
#if not audio_stream_dash.is_playing():
#	audio_stream_dash.stream = sfx_dash
#	audio_stream_dash.play()
#	
#if not audio_stream_slide.is_playing() and Input.is_action_pressed("sprint"):
#	audio_stream_slide.stream = sfx_slide
#	audio_stream_slide.play()


#PlayerVariables.location = self.global_transform.origin
#PlayerVariables.body = self
#PlayerVariables.current_speed=current_speed

#var input_dir = Input.get_vector("left", "right", "up", "down")
#-----





# Called when the node enters the scene tree for the first time.
func _ready():
	
	L_interact.text = str("")
	R_interact.text = str("")
	flash_light.visible=false
	#bam.visible=false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PlayerVariables.pistol_reserve + PlayerVariables.pistol_loaded==0:
		reload_label.text=str("no ammo")
		#reload_label.text.modulate(Color(1,0,0,1))
	else:
		reload_label.text=str("RELOAD!")
		#reload_label.
	if PlayerVariables.pistol_loaded==0:
		PlayerVariables.empty_gun=true
	else:
		PlayerVariables.empty_gun=false
		
	if PlayerVariables.empty_gun==true:
		reload_label.visible=true
		#await get_tree().create_timer(0.07).timeout
		#reload_label.visible=false
	else:
		reload_label.visible=false
	pistol_loaded.text=str(PlayerVariables.pistol_loaded)
	pistol_reserve.text=str("/",PlayerVariables.pistol_reserve)
	
	r_pistol.visible=false
	l_pickaxe.visible=false
	
	#arm and tool visibility
	#r_pickaxe.visible=false
	#r_pistol.visible=false
	#r_empty.visible=false
	
	#l_pickaxe.visible=false
	#l_pistol.visible=false
	#l_empty.visible=false
	
	#if PlayerVariables.L_selector==0:
		#l_empty.visible=true
		#l_pistol.visible=false
		#l_pickaxe.visible=false
		
		#l_pistol.visible=false
		#l_pickaxe.visible=false
		
		#l_pistol.visible=false
		#l_pickaxe.visible=false
		
	#if PlayerVariables.L_selector==1:
		#l_pickaxe.visible=true
		#l_pistol.visible=false
		#l_empty.visible=false
		
	#if PlayerVariables.L_selector==2:
		#l_pistol.visible=true
		#l_empty.visible=false
		#l_pickaxe.visible=false
	#else:
		#l_empty.visible=true
		
		#l_pickaxe.visible=false
		#l_pistol.visible=false
		#l_pickaxe.visible=false
		#l_pistol.visible=false
		##------------------------------
		#pass
		
	#if PlayerVariables.R_selector==0:
		#r_empty.visible=true
		#r_pistol.visible=false
		#r_pickaxe.visible=false
	#if PlayerVariables.R_selector==1:
		#r_pickaxe.visible=true
		#r_pistol.visible=false
		
	#if PlayerVariables.R_selector==2:
		#r_pistol.visible=true
		
		#r_pickaxe.visible=false
	#else:
		#r_empty.visible=true
		
	
	
		#r_pickaxe.visible=false
		#r_pistol.visible=false
		
	
	#stamina gain
	
	
	if PlayerVariables.stamina <100:
		PlayerVariables.stamina+=.4
	#left and right arm, animations
	
	if  Input.is_action_just_pressed("interact_1"):
			l_pickaxe.visible=true
		#if PlayerVariables.L_selector!=2: #not holding the gun
			
			#l_arm.rotation_degrees.x=lerp(rad_to_deg(95),rad_to_deg(55),.05)
			#l_arm.position.z=lerpf(l_arm.position.z,-3.5,.5)
			
			#await get_tree().create_timer(0.07).timeout
			
			#l_arm.rotation_degrees.x=-35
			#l_arm.position.z=lerpf(l_arm.position.z,1.5,.5)
			
			l_arm.rotation_degrees.x=lerp(rad_to_deg(95),rad_to_deg(55),.05)
			l_arm.position.z=lerpf(l_arm.position.z,-3.5,.5)
			
			await get_tree().create_timer(0.07).timeout
			
			l_arm.rotation_degrees.x=-35
			l_arm.position.z=lerpf(l_arm.position.z,1.5,.5)
			
		#if PlayerVariables.L_selector==2 and PlayerVariables.pistol_loaded>0:
			
			
			
			
			#l_arm.rotation_degrees.x=lerp(rad_to_deg(95),rad_to_deg(55),.05)
			#l_arm.position.z=lerpf(l_arm.position.z,-1.5+c,.5)
			
			#await get_tree().create_timer(0.1).timeout
			#l_bamv()
			
		
				
			
				
			
	#else:
		
		#l_arm.rotation_degrees.x=-35
		#l_arm.position.z=lerpf(l_arm.position.z,1.5,.5)
	r_pistol.visible=true
	#if  Input.is_action_pressed("interact_2"):
		
		#if PlayerVariables.R_selector!=2: #not holding the gun
			#r_arm.rotation_degrees.x=lerp(rad_to_deg(95),rad_to_deg(55),.05)
			#r_arm.position.z=lerpf(r_arm.position.z,-1.5+c,.5)
			
			#await get_tree().create_timer(0.07).timeout
			
			#r_arm.rotation_degrees.x=-35
			#r_arm.position.z=lerpf(r_arm.position.z,1.5,.5)
			
		#if PlayerVariables.R_selector==2 and PlayerVariables.pistol_loaded>0:
		#if PlayerVariables.pistol_loaded>0:
			
			
			#r_arm.rotation_degrees.x=lerp(rad_to_deg(95),rad_to_deg(55),.05)
			#r_arm.position.z=lerpf(r_arm.position.z,-1.5+c,.5)
			#cc+=1
			#await get_tree().create_timer(0.1).timeout
			#r_bamv()
	r_bam.visible=false
			#if cc>=30:
			#r_arm.position.z=lerpf(r_arm.position.z,2,.5)
			#r_bamv()
				#cc=0
				
	#else:
		#r_arm.rotation_degrees.x=-35
		#r_arm.position.z=lerpf(r_arm.position.z,1.5,.5)
	#else:
		#await get_tree().create_timer(0.07).timeout
	r_arm.rotation_degrees.x=-65
	r_arm.position.z=lerpf(r_arm.position.z,-0.5,.5)
	#if self.is_colliding():
		
		#var collider=self.get_collider()
		#add_exception(PlayerVariables.body)
		#add_exception(PlayerVariables.world)
		#add_exception(PlayerVariables.i_floor)
		#self.add_exception(PlayerVariables.i_health)
		#self.add_exception(PlayerVariables.i_ammo)
		#print("selector: ",collider.name)
		#if Input.is_action_just_pressed("interact_1"):
			#if collider.is_instance_valid():
			#if collider.name=="humanoid" or collider.name=="spawn_crystal":
				#collider.health-=100
		#if Input.is_action_just_pressed("interact_2"):
			#if collider.name=="humanoid" or collider.name=="spawn_crystal":
			#if collider.is_instance_valid():
				#collider.health-=100
		
	
	
		#######
		#######
		#######
		
	#if selector.is_colliding():
		
		#var collider=selector.get_collider()
		#PlayerVariables.collider=collider.get_parent()
		#print( "collider:", collider)
		
		#if collider.get_collider().name=="spawn_crystal": #pointing at a rock
			
			#print(collider.get_collision_mask_value(2))
			
			#if PlayerVariables.L_selector>0.9 and PlayerVariables.L_selector<2:
				#L_interact.text = str(" LMB ")
				#if Input.is_action_just_pressed("interact_1"):
					#collider.get_parent().health-=1
					
					#PlayerVariables.stone = PlayerVariables.stone+randi_range(1,2)
			#else:
				#L_interact.text = str("")
			
			#if PlayerVariables.R_selector>0.9 and PlayerVariables.R_selector<2:
			#	R_interact.text = str(" RMB ")
				#if Input.is_action_just_pressed("interact_2"):
				#	collider.get_parent().health-=1
					#PlayerVariables.stone = PlayerVariables.stone+randi_range(1,2)
			
			
			
			
			#else:
				#L_interact.text = str("")
				#R_interact.text = str("")
		#if collider.get_collision_mask_value(3)==true: #is wood????
			#if Input.is_action_pressed("interact"):
				#c_timer = c_timer+1
				#if c_timer>=30:
					#PlayerVariables.stone = PlayerVariables.stone+1
					#c_timer=0
			#interact.text = str(" E ")
				
		
	#else:
		#R_interact.text = str("")
		#L_interact.text = str("")
		#if collider.get_collision_mask_value(2)==false:
			#interact.text = str("")
		
func _input(event):
	
	if Input.is_action_just_pressed("reload") and PlayerVariables.pistol_loaded!=30: #reload
		if PlayerVariables.pistol_reserve<30:
			var all=PlayerVariables.pistol_reserve
			PlayerVariables.pistol_reserve-=all
			await get_tree().create_timer(0.3).timeout
			PlayerVariables.pistol_loaded=all
		else:
			
			PlayerVariables.pistol_reserve-=30
			await get_tree().create_timer(0.3).timeout
			PlayerVariables.pistol_loaded=30
		
	
		#escape to exit

	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

#flash_light

	if Input.is_action_just_released("f"):
		if flash_light.visible:
			flash_light.visible=false
		else:
			flash_light.visible=true
			
			
	if not Input.is_action_pressed("L_switch") and not Input.is_action_pressed("R_switch"):
		if Input.is_action_just_released("scroll_up"):
			if flash_light.spot_angle>=25:
				flash_light.spot_angle-=5
				flash_light.spot_range-=.5
				flash_light.light_energy+=1
		if Input.is_action_just_released("scroll_down"):
			if flash_light.spot_angle<=45:
				flash_light.spot_angle+=5
				flash_light.spot_range+=.5
				flash_light.light_energy-=1
	
	
		
	#inventory
	
	if Input.is_action_pressed("inventory"):
		stone.visible=true
	else:
		stone.visible=false
	
	#hotbar
	
	#if Input.is_action_just_pressed('1'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=1

	#if Input.is_action_just_pressed('2'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=2

	#if Input.is_action_just_pressed('3'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=3

	#if Input.is_action_just_pressed('4'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=4

	#if Input.is_action_just_pressed('5'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=5

	#if Input.is_action_just_pressed('6'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=6

	#if Input.is_action_just_pressed('7'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=7

	#if Input.is_action_just_pressed('8'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=8

	#if Input.is_action_just_pressed('9'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=9

	#if Input.is_action_just_pressed('0'):
		#PlayerVariables.R_selector=PlayerVariables.L_selector
		#PlayerVariables.L_selector=0
		
	
	
	#if Input.is_action_pressed("L_switch"):
		#if Input.is_action_just_released("scroll_up"):
			#PlayerVariables.L_selector+=1
		#if Input.is_action_just_released("scroll_down"):
			#PlayerVariables.L_selector-=1
		
	#if Input.is_action_pressed("R_switch"):
		#if Input.is_action_just_released("scroll_up"):
			#PlayerVariables.R_selector+=1
		#if Input.is_action_just_released("scroll_down"):
			#PlayerVariables.R_selector-=1
			
				
	#PlayerVariables.R_selector=round(PlayerVariables.R_selector)
	#PlayerVariables.L_selector=round(PlayerVariables.L_selector)
	#view

	#if Input.is_action_pressed("view"):
		#if Input.is_action_just_released("scroll_up") and spring_arm_3d.position.z>0:
			#spring_arm_3d.transform.origin.z-=.5
			#spring_arm_3d.transform.origin.y-=.1
			#selector.target_position.y-=.10
		#if Input.is_action_just_released("scroll_down") and spring_arm_3d.position.z<5:
			#spring_arm_3d.transform.origin.z+=.5
			#spring_arm_3d.transform.origin.y+=.1
			#selector.target_position.y+=.10
			
	#if Input.is_action_pressed("interact_2"):
		#camera_3d.fov=60
	#if Input.is_action_just_released("interact_2"):
		#camera_3d.fov=75
		
		
	if Input.is_action_pressed("zoom"):
		if Input.is_action_just_released("scroll_up"):
			camera_3d.fov-=3
		if Input.is_action_just_released("scroll_down"):
			camera_3d.fov+=3
			
			
	#if Input.is_action_just_released("view") and cam==2:
		#spring_arm_3d.transform.origin.z-=4
		#spring_arm_3d.transform.origin.y+=1
		#cam=1
	#else:
		#if Input.is_action_just_released("view"):
			#spring_arm_3d.transform.origin.z+=4
			#spring_arm_3d.transform.origin.y-=1
			#cam=2
	
	
#func l_bamv():
	
	#if l_bam.visible==false:
		#l_arm.position.z=lerpf(l_arm.position.z,-1,.1)
		#await get_tree().create_timer(0.07).timeout
		#l_bam.visible=true
		#print("L true")
			
	#if l_bam.visible==true:
		#await get_tree().create_timer(0.07).timeout
		#l_arm.position.z=lerpf(l_arm.position.z,1,.1)
		#l_bam.visible=false
		#print("L false")
		
		
func r_bamv():
	if r_bam.visible==false:
		r_arm.position.z=lerpf(r_arm.position.z,-1,.1)
		await get_tree().create_timer(0.07).timeout
		r_bam.visible=true
		#print("R true")
	if r_bam.visible==true:
		await get_tree().create_timer(0.07).timeout
		r_arm.position.z=lerpf(r_arm.position.z,1,.1)
		r_bam.visible=false
		#print("R false")



