extends Node3D

@onready var health = $health/health
@onready var label = $Label3D


# Called when the node enters the scene tree for the first time.
func _ready():
	name="health"
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text=name
	PlayerVariables.i_health=health
	pass


func _on_area_3d_body_entered(body):
	if body==PlayerVariables.body:
		PlayerVariables.health+=100
		queue_free()
	pass # Replace with function body.
