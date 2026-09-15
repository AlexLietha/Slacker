extends RayCast3D

var canInteract = true
var lastHovered = null
var interactor: Player

func _ready() -> void:
	interactor = get_parent().get_parent()
	
	
func _process(_delta: float) -> void:
	if lastHovered:
		lastHovered.Hover(interactor, false)
		
	var collider = get_collider()
	
	if not collider:
		return
	
	var interactable = collider.get_node_or_null("InteractableComponent")
	
	if not interactable:
		return
		
	if not interactable.isHovered:
		lastHovered = interactable
		interactable.Hover(interactor, true)
		#print("Highlighted")

	if Input.is_action_just_pressed("interact") and canInteract and interactable.Interactable:
			interactable.Interact(interactor)
