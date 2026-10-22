extends Node3D
class_name Order_Board

@export var OrderSpots: Array[Node3D]
var ticket_scene : PackedScene = preload("uid://dv3flcatigubx")
var spawnSpot: int = 0

var debug_print_source = "[order_board.gd] - "

func _ready() -> void:
	OrderManager.StartedOrder.connect(spawn_ticket)
	OrderManager.CompletedOrder.connect(delete_ticket)

func spawn_ticket(order: Order) -> void:
	print(debug_print_source + "Making Ticket")
	
	if order.get_entree() == null:
		printerr(debug_print_source + "Order has no entree assigned!")
		return

	var ticket = ticket_scene.instantiate()
	add_child(ticket)
	ticket.move_ticket(OrderSpots[spawnSpot % 9].position)
	spawnSpot += 1
	
	ticket.set_order(order)
	ticket.set_text(order.get_entree().get_name())
	
	print(debug_print_source + "Ticket made")
	print(debug_print_source + order.get_entree().get_name() + " on ticket")
	#ticket.transform.origin = Vector3.ZERO
	
func delete_ticket(order: Order)-> void:
	print(debug_print_source + "Deleting ticket") #😭
	for child in get_children():
		if child is OrderTicket && child.order == order:
			child.queue_free()
			print(debug_print_source + "Delete complete!")
		else:
			continue
			
	
	#for i in OrderSpots.size():
		#var ticket = tickets.instantiate()
		#tickets.position = OrderSpots[i].position
