extends Node3D

@onready var Target = $Target

func _physics_process(_delta):
	get_tree().call_group("Prayers","update_target_location",Target.global_transform.origin)
