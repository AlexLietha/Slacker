extends RayCast3D

var canInteract = true

func _process(_delta: float) -> void:
	var collider = get_collider()


	if collider == InteractableComponent:
		print(get_collider().get_class())
	
	

	if Input.is_action_just_pressed("interact") and canInteract:
		if collider:
			var interactable = collider.get_node_or_null("InteractableComponent")

			if interactable:
				interactable.Interact(self.get_parent().get_parent())
