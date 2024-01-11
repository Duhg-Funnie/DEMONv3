extends Node3D
@onready var area_3d = $MeshInstance3D2/Area3D

@onready var i_floor = $MeshInstance3D2/Area3D/lava_collision

@onready var i_lava = $MeshInstance3D2/StaticBody3D/floor_collision

#signal wet

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func _physics_process(_delta):
	PlayerVariables.i_lava=i_lava
	#get_tree().call_group("enemies", "update_target_position")
