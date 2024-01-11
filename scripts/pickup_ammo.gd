extends Node3D
@onready var ammo = $ammo/ammo
@onready var label = $Label3D


# Called when the node enters the scene tree for the first time.
func _ready():
	name="ammo"
	PlayerVariables.i_ammo=ammo
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text=name
	pass


func _on_area_3d_body_entered(body):
	if body==PlayerVariables.body:
		PlayerVariables.pistol_reserve+=30
		queue_free()
	pass # Replace with function body.
