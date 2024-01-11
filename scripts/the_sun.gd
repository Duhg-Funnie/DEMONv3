extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	light_energy=PlayerVariables.world_light
	#if light_energy>0:
		#light_energy-=.001
	#light_energy+=PlayerVariables.kills/16
	#print(light_energy)
	pass
