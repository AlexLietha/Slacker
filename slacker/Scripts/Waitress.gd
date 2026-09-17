extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var idComponent: IDComponent

func _ready() -> void:
	interactableComponent.interacted.connect(GiveFood)

func GiveFood(player: Player):
	if not player.HasGrabbedItem():
		return
	
	OrderManager
	player.getGrabbedItem().queue_free()
		#OrderManager.ReportEvent("Deliver", "waitress", 1)
