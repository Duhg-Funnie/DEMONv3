extends Node3D
@onready var l_bullet = $l_bullet
@onready var r_bullet = $r_bullet

var hit_particles = preload("res://scenes/hit_particles.tscn")

var counter =0
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x=randf_range(-.2,.2)
	position.y=randf_range(-.2,.2)
	
	l_bullet.visible=false
	r_bullet.visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	#if Input.is_action_pressed("interact_1") and PlayerVariables.L_selector>1.9 and PlayerVariables.L_selector<3:
		#l_bullet.visible=true
	#if Input.is_action_just_released("interact_1"):
		#l_bullet.visible=false
	if Input.is_action_pressed("interact_2"):
		r_bullet.visible=true
	#if Input.is_action_just_released("interact_2"):
		#r_bullet.visible=false
	
		
		
func _physics_process(delta):
	counter+=1
	if counter<1000:
		position.z=position.z-100*delta
		l_bullet.position.x+=.5
		r_bullet.position.x-=.5
		r_bullet.position.y+=.3
	else:
		queue_free()


func _on_area_3d_body_entered(body):
	#var ihit=hit_particles.instantiate()
	#PlayerVariables.location
		
	#add_child(ihit)
	#await get_tree().create_timer(0.5).timeout
	#queue_free()
	pass # Replace with function body.
