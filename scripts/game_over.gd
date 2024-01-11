extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	pass


func _on_button_pressed():
	print("restarting...")
	PlayerVariables.restart_game=true
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	pass # Replace with function body.
