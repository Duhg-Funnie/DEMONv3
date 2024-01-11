extends Sprite3D
@onready var crosshair = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	var center= get_viewport().get_size()/2
	crosshair.position.x=center
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
