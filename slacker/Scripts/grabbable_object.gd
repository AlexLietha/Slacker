extends RigidBody3D

@export var interactableComponent: InteractableComponent
@export var grabbableComponent: GrabbableComponent
@export var idComponent: IDComponent

func _ready() -> void:
	interactableComponent.GetSignal().connect(Grab)


func Grab(grabber : CharacterBody3D):
	pass
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
