extends RigidBody3D
class_name GrabbableObject
@export var interactableComponent: InteractableComponent
@export var grabbableComponent: GrabbableComponent
@export var idComponent: IDComponent
@export var model: CSGCylinder3D

func _ready() -> void:
	interactableComponent.GetSignal().connect(Grab)


func Grab(grabber : CharacterBody3D):
	pass
	if not grabbableComponent.Grabbable:
		return
		
	print(grabber)

	self.reparent(grabber.get_child(4))
	self.position = Vector3.ZERO
	self.freeze = true
	OrderManager.report_event("Retrieve", idComponent.GetID(), 1)
	#grabber.get_child(0).get_child(0).canInteract = false
	set_collision_layer_value(2, false)

	

func drop():
	self.position = Vector3.ZERO
	self.freeze = true
	set_collision_layer_value(2, true)
	
func cook():
	model.material.albedo_color = Color(0.293, 0.18, 0.146, 1.0)
	
