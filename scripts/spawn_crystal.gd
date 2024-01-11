extends Node3D
#@onready var spawn_crystal = $spawn_crystal
#@onready var spawn_crystal = $spawn_crystal/MeshInstance3D/spawn_crystal/spawn_crystal
@onready var spawn_crystal = $spawn_crystal/MeshInstance3D/spawn_crystal
@onready var name_label = $spawn_crystal/name
@onready var health_label = $spawn_crystal/health
@onready var explode = $spawn_crystal/explode

#@onready var explode = $explode
#@onready var health_label = $health
#@onready var name_label = $name
#@onready var spawn_crystal = $MeshInstance3D/spawn_crystal

@onready var game = $".."
var p=Vector3()
var humanoid = preload("res://scenes/humanoid.tscn")
var humanoid_2 = preload("res://scenes/humanoid_2.tscn")

var pickup_health=preload("res://scenes/pickup_health.tscn")
#var health=15
# Called when the node enters the scene tree for the first time.
var b=0
var counter=0
var spawn_total=10
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	position.x=randf_range(-70,70)
	position.z=randf_range(-70,70)
	
	#var scale_up=randf_range(-.2,.2)
	#size =rand()
	#if size>10
	#scale+=Vector3(scale_up,scale_up,scale_up)
	name="spawn_crystal"
	p=global_transform.origin


func _process(delta):
	
	#print("spawn:", name)
	rotate_y(get_node("spawn_crystal/MeshInstance3D/spawn_crystal").health/20*delta)
	
	#lerpf(r_arm.position.z,1.5,.5)
	if spawn_crystal.health<=0:
		PlayerVariables.world_light-=.1*delta
		rotate_y(5*delta)
		if counter<=2:
			
			var i_humanoid_2 = humanoid_2.instantiate()
			
			var badguy_2 = Node3D.new()
			badguy_2.add_child(i_humanoid_2)
			badguy_2.name="humanoid"
			#for child in parent.get_children():
				#child.name="humanoid"
				#print("created: ", child)
				#child.position=(position)
			game.add_child(badguy_2)
			
			
			counter+=1
			#remove_child(parent)
		explode.visible=true
		b+=1
		if b>=30:
			
			var drop=pickup_health.instantiate()
			drop.position=position
			#if drop.position.y>.5:
			drop.position.y+=.4
			
			get_node("..").add_child(drop)
			
			PlayerVariables.last_crystal_position=self.global_transform.origin
			PlayerVariables.kills+=1
			queue_free()
			b=0
	else:
		health_label.text=str(spawn_crystal.health)
		name_label.text=str(spawn_crystal.name)
	#for child in get_children():
		#child.name="humanoid"
	if PlayerVariables.total_enemy_count<=spawn_total:
		
		var i_humanoid = humanoid.instantiate()
		
		var badguy_1 = Node3D.new()
		
		badguy_1.add_child(i_humanoid)
		#for child in parent.get_children():
			#child.name="humanoid"
			#print("created: ", child)
		i_humanoid.name="humanoid"
		PlayerVariables.total_enemy_count+=1
		#add_child(badguy_1)
		game.add_child(badguy_1)
		#spawn_total+=1
			
	pass # Replace with function body.
	
		
			
