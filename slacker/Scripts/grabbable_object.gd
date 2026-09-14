extends RigidBody3D
class_name GrabbableObject
@export var interactableComponent: InteractableComponent
@export var grabbableComponent: GrabbableComponent
@export var highlightComponent: HighlightComponent
@export var idComponent: IDComponent
@export var model: CSGCylinder3D



func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(Grab)
	interactableComponent.GetHoveredSignal().connect(highlightComponent.highlight)
	
	
	highlightComponent.SetShader(model.material.next_pass)


func Grab(grabber : Player):
	
	if not grabbableComponent.Grabbable:
		return
		
	print(grabber)

	self.reparent(grabber.get_child(4))
	self.position = Vector3.ZERO
	self.freeze = true
	#OrderManager.ReportEvent("Retrieve", idComponent.GetID(), 1)
	#grabber.get_child(0).get_child(0).canInteract = false
	set_collision_layer_value(2, false)

	

func drop():
	self.reparent(get_tree().root)
	#self.position = Vector3.ZERO
	self.freeze = false
	set_collision_layer_value(2, true)
	
	
func cook():
	model.material.albedo_color = Color(0.293, 0.18, 0.146, 1.0)
	SetName("cookedBurgerPatty")
	
func GetName() -> String:
	return idComponent.GetID()
	
func SetName(id: String) -> void:
	idComponent.SetID(id)
	
