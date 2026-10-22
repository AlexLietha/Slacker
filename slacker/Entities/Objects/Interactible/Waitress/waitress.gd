extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var idComponent: IDComponent

func _ready() -> void:
	interactableComponent.interacted.connect(give_food)

func give_food(player: Player):
	if not player.has_grabbed_item():
		return
	
	#OrderManager
	if player.get_grabbed_item() is Plate:
		if player.get_grabbed_item().get_item() == null:
			print("nothing on plate")
			return
		
		OrderManager.complete_order(player.get_grabbed_item())
		player.get_grabbed_item().queue_free()
		#OrderManager.ReportEvent("Deliver", "waitress", 1)
