extends Node3D
var spawn_crystal=preload("res://scenes/spawn_crystal.tscn")
var total=0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if total<10:
		var c=spawn_crystal.instantiate()
		add_child(c)
		c.name="spawn_crystal"
		total+=1
	pass
