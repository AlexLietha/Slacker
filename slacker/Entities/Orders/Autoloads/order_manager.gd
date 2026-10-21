extends Node

var activeOrders: Array[Order] = []
var completedOrders: Array[Order] = []

signal StartedOrder(order: Order)
signal CompletedOrder(order: Order)

var orderInt := 0

func _ready() -> void:
	pass
	#OrderSpawner.get_new_signal_order().connect(start_order)
	
func start_order(order: Order) -> Order:
	orderInt += 1
	
	order.set_order_ID(orderInt)
	activeOrders.append(order)
	
	StartedOrder.emit(order)
	
	return order

func get_order(id: int) -> Order:
	for order : Order in activeOrders:
		if order.GetOrderID() == id:
			return order
	return null

func get_active_orders() -> Array:
	return activeOrders

#func FindClosestOrder(plate: Plate) -> Order:
	#for order in activeOrders:
		#pass
	#pass

func complete_order(plate : Plate) -> bool:
	var plateEntree = plate.get_item()
	
	for order : Order in activeOrders:
		if order.get_entree().get_name() == plateEntree._get_name():
			if plateEntree.cooked:
				order.set_score(100)
			print("Completed Order")
			CompletedOrder.emit(order)
			
			activeOrders.erase(order)
			completedOrders.append(order)
			return true
	return false
	
