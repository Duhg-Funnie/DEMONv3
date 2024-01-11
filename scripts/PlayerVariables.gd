extends Node


var stone = 0
var stamina = 100
var collider = Object
var health = 100
var pistol_loaded = 0
var pistol_reserve = 60
var empty_gun=true
var ouch = false
var ouch_sprite=ColorRect
#left and right hands
var L_selector = 0
var R_selector = 0

var location = Vector3()

var enemy_aim = Vector3()
var body = Node3D

var hotbar = [0, 0, 0, 0, 0 ,0 ,0 ,0]
var i_lava=CollisionObject3D
var i_floor=CollisionObject3D
var current_speed=0

var jump_pad = Area3D

var area_home = Area3D
var restart_game=false
var total_enemy_count=0
var last_crystal_position=Vector3()
var kills=0
var world_light=0

var i_ammo=CollisionObject3D
var i_health=CollisionObject3D


var l_time=0
var m_time=0
var h_time=0



#var os=ouch_sprite.new()

#var inventory = [0, 0, 0, 0, 0 ,0 ,0 ,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	if stamina<0:
		stamina=0
	
	#if PlayerVariables.ouch==true:
		#if is_instance_valid(ouch_sprite):
			#os.set_color(Color(0,0,0,0))
			
			#PlayerVariables.health-=1
	#else:
		#if is_instance_valid(ouch_sprite):
			#os.visible=false
			#os.set_color(Color(1,0,0,.5))
	
	
	l_time+=3
	m_time+=4
	h_time+=9
	
	
	if l_time >256: 
		l_time=0
	if m_time >256: 
		m_time=0
	if h_time >256: 
		h_time=0
	pass
