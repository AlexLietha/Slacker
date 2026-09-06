extends Node


var active_orders: Dictionary = {}
var completed_orders: Dictionary = {}

signal StartedOrder(order: Order)
signal AdvancedOrder(order: Order)
signal CompletedOrder(order: Order)


func start_order(order_template: Order) -> Order:
	var order: Order = order_template.duplicate(true)

	order.instance_id = generate_instance_id(order.order_id)
	active_orders[order.instance_id] = order
	
	StartedOrder.emit(order)
	print("Started order: ", order.title)
	print("Instance ID: ", order.instance_id)
	#print("active orders:", active_orders)

	return order


func generate_instance_id(order_id: String) -> String:
	return order_id + "_" + str(Time.get_ticks_usec())


func get_order(instance_id: String) -> Order:
	return active_orders.get(instance_id)


func get_active_orders() -> Array:
	return active_orders.values()


func report_event(event_type: String, target_id: String, amount: int = 1) -> void:

	for order in active_orders.values():
		var step: TaskStep = order.get_current_step()

		if step == null:
			continue

		if step.matches_event(event_type, target_id):
			step.progress(amount)
			
			print(
				order.title,
				": ",
				step.description,
				" ",
				step.current_amount,
				"/",
				step.required_amount
			)

			order.check_progress()
			AdvancedOrder.emit(order)
			if order.completed:
				complete_order(order)
				CompletedOrder.emit(order)
		return


func complete_order(order: Order) -> void:
	active_orders.erase(order.instance_id)

	completed_orders[order.instance_id] = order
	
	CompletedOrder.emit(order)
	print("Order completed: ", order.title)
