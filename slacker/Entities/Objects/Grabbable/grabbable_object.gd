extends RigidBody3D
class_name GrabbableObject

@export var interactableComponent: InteractableComponent
@export var grabbableComponent: GrabbableComponent
@export var highlightComponent: HighlightComponent
@export var idComponent: IDComponent

@export var model: CSGCylinder3D

var plate : Plate


func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(grab)
	interactableComponent.GetHoveredSignal().connect(highlightComponent.highlight)
	
	highlightComponent.set_shader(model.material.next_pass)


func grab(grabber : Player):
	print("1")
	if not grabbableComponent.Grabbable:
		return
		
	if grabber.has_grabbed_item():
		
		return
	if plate:
		plate.remove_item(self)
		plate = null
	
	
		
	print(grabber)

	reparent(grabber.grabbedItem)
	position = Vector3.ZERO
	freeze = true
	#cooking = false
	#OrderManager.ReportEvent("Retrieve", idComponent.GetID(), 1)
	#grabber.get_child(0).get_child(0).canInteract = false
	set_collision_layer_value(2, false)

func place(newPosition: Node3D):
	self.reparent(newPosition)
	self.position = Vector3(0, .01, 0)
	self.freeze = true
	set_collision_layer_value(2, true)
	
func drop():
	self.reparent(get_tree().root)
	#self.position = Vector3.ZERO
	self.freeze = false
	set_collision_layer_value(2, true)
	
	

	
func _get_name() -> String:
	return idComponent.GetID()
	
func _set_name(id: String) -> void:
	idComponent.SetID(id)
	
#func AddItem(item: GrabbableObject) -> void:
	#item.Place(stackPos)
	
func get_height() -> float:
	return model.height
	
