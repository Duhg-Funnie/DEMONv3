extends Camera3D

var ray_range = 1000
var is_hitting = false
var cross=PhysicsRayQueryParameters3D
var bullet=preload("res://scenes/bullet.tscn")
var hit_particles=preload("res://scenes/hit_particles.tscn")
var dual=0

#var hit_particles=preload("res://scenes/hit_particles.tscn")

func _input(_event):
	
	if Input.is_action_pressed("interact_1") or Input.is_action_pressed("interact_2"):
		#if PlayerVariables.R_selector>1.9 and PlayerVariables.R_selector<3 or PlayerVariables.L_selector>1.9 and PlayerVariables.L_selector<3:
		get_camera_collision()

func get_camera_collision():
	var center= get_viewport().get_size()/2
	var ray_origin = project_ray_origin(center)
	var ray_end = ray_origin + project_ray_normal(center)*ray_range
	
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	
	#var pe = PhysicsRayQueryParameters3D.create(global_position, player_position)
	new_intersection.exclude = [self,PlayerVariables.body]
	
	var intersection = get_world_3d().direct_space_state.intersect_ray(new_intersection) #dictionary
	cross = intersection
	#var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 1, [self])
	
	if not intersection.is_empty():
		print("hit: ", intersection.collider.name)
		#if intersection.collider.name=="humanoid":
		if intersection.collider.name=="humanoid" or intersection.collider.name=="spawn_crystal":
			is_hitting=true
			
	else:
		is_hitting=false
		print("nothing")
	
	

func _process(_delta):
	
	if Input.is_action_just_pressed("interact_1") or Input.is_action_pressed("interact_2") :
		#if PlayerVariables.R_selector==2 or PlayerVariables.L_selector==2:
		
			
		if PlayerVariables.pistol_loaded>=1:
			var ibullet= bullet.instantiate()
			get_node(".").add_child(ibullet)
		#var ihit=hit_particles.instantiate()
		#if is_instance_valid(cross.collider):
			#ihit.position=cross.collider.position
			#get_node("../..").add_child(ihit)
		if Input.is_action_pressed("interact_2") and PlayerVariables.pistol_loaded>=1:
			PlayerVariables.pistol_loaded-=1
			
			
		if is_hitting==true:
			#if PlayerVariables.R_selector==2 or PlayerVariables.L_selector==2:
			if Input.is_action_pressed("interact_2") and PlayerVariables.pistol_loaded>=1:
				
				if is_instance_valid(cross.collider):
					if cross.collider.name=="humanoid": 
						cross.collider.health-=3 # default = 2
					if cross.collider.name=="spawn_crystal":
						cross.collider.health-=1 # default = 1
					else:
						#var ihit= hit_particles.instantiate()
						#get_node(".").add_child(ihit)
						pass
			#if PlayerVariables.R_selector==1 or PlayerVariables.L_selector==1:
			if Input.is_action_just_pressed("interact_1"):
				
					
				if is_instance_valid(cross.collider):
					if cross.collider.name=="humanoid": 
						cross.collider.health-=50
					if cross.collider.name=="spawn_crystal":
						cross.collider.health-=50
					else:
						
						pass
						
	
			#if Input.is_action_pressed("interact_1") and Input.is_action_pressed("interact_2")
				#cross.collider.health-=2
				print("hitting this:", cross.collider.name)
