extends VBoxContainer

func _ready() -> void:
	OrderManager.StartedOrder.connect(AddOrder)
	OrderManager.AdvancedOrder.connect(UpdateOrder)
	OrderManager.CompletedOrder.connect(DeleteOrder)

func AddOrder(order: Order) -> void:
	var label = OrderElement.new()
	add_child(label)
	label.order = order
	label.fit_content = true
	label.text = order.get_current_step().description

func UpdateOrder(order: Order) -> void:
	print("Updating Order UI")
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			child.text = order.get_current_step().description
	pass

func DeleteOrder(order: Order) -> void:
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			remove_child(child)
		
