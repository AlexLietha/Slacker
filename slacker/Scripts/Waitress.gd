extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var idComponent: IDComponent

func _ready() -> void:
	interactableComponent.interacted.connect(GiveFood)

func GiveFood(player: Player):
	if not player.HasGrabbedItem() or player.getGrabbedItem() is not Plate:
		return
		
	if player.getGrabbedItem().GetItem() == null:
		return
		
	var plate = player.getGrabbedItem()
		
	print(player.getGrabbedItem().GetItem().GetName())
	if OrderManager.CompleteOrder(plate):
		player.getGrabbedItem().queue_free()
		#OrderManager.ReportEvent("Deliver", "waitress", 1)
