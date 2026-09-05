extends RigidBody3D

@export var interactableComponent: InteractableComponent
@export var grabbableComponent: GrabbableComponent


func _ready() -> void:
	interactableComponent.GetSignal().connect(Grab)


func Grab(grabber : CharacterBody3D):
	pass
	print(grabber)

	self.reparent(grabber.get_child(4))
	self.position = Vector3.ZERO
	self.freeze = true
	grabber.get_child(0).get_child(0).canInteract = false
	# Interactor will grab the object
