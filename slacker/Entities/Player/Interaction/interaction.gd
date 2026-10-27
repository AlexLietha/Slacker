extends RayCast3D

var canInteract = true
var lastHovered = null
var interactor: Player

func _ready() -> void:
	interactor = get_parent().get_parent().get_parent().get_parent()

func unhover() -> void:
	if lastHovered != null:
		lastHovered.Hover(interactor, false)
		lastHovered = null

func _process(_delta: float) -> void:
	# Wait and do this later when we change hover
	#if lastHovered:
		#lastHovered.Hover(interactor, false)
		
	var collider = get_collider()
	
	if not collider:
		unhover()
		return
	
	var interactable = collider.get_node_or_null("InteractableComponent")
	#print(collider)
	if not interactable and collider.get_parent():
		interactable = collider.get_parent().get_node_or_null("InteractableComponent")
	
	if not interactable:
		unhover()
		return
		
	if not interactable.isHovered:
		if lastHovered != interactable:
			unhover()
			lastHovered = interactable
			interactable.Hover(interactor, true)
			#print("Highlighted")

	if Input.is_action_just_pressed("interact") and canInteract and interactable.Interactable:
			interactable.Interact(interactor)
