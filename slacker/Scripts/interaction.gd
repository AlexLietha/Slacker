extends RayCast3D

func _process(delta: float) -> void:
	#if get_collider():
		#print(get_collider().get_class())
		
	if Input.is_action_just_pressed("interact"):
		if get_collider():
			get_collider().Interact(self.get_parent())
