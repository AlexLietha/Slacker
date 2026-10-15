extends GrabbableObject
class_name Broom

var original_collision_layer: int
var original_collision_mask: int

@onready var grabPoint : Marker3D = $GrabPoint

func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(Grab)
	
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask

	# Highlighting temporarily disabled
	# interactableComponent.GetHoveredSignal().connect(highlight)
	
func Grab(grabber: Player) -> void:
	print("time for witch craft")
	super.Grab(grabber)
	
	if get_parent() != grabber.grabbedItem:
		return

	rotation = Vector3.ZERO  # Rotate the broom upright to prevent BroomGoBrr.mp4
	
	position = -grabPoint.position
	
	# turn off collision so the player can't pick up the broom while holding the broom,
	# and so the broom doesn't have collision with anything else
	collision_layer = 0
	collision_mask = 0
	
func drop() -> void:
	print("broom dropped")
	super.drop()
	
	collision_layer = original_collision_layer
	collision_mask = original_collision_mask

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
