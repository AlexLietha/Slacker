extends Node3D
class_name Order_Board

@export var OrderSpots: Array[Node3D]
var ticket_scene : PackedScene = preload("res://Scenes/order_ticket.tscn")
var spawnSpot: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	OrderManager.StartedOrder.connect(_spawnTicket)
	OrderManager.CompletedOrder.connect(_deleteTicket)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _spawnTicket(order: Order) -> void:
	
	print("Making Ticket")
	var ticket = ticket_scene.instantiate()
	add_child(ticket)
	ticket.Move_Ticket(OrderSpots[spawnSpot%9].position)
	spawnSpot += 1
	ticket.Set_Owner(order)
	ticket.Set_Text(order.GetEntree().GetName())
	print(order.GetEntree().GetName()+" On ticket")
	print("Ticket Made")
	print(get_children())
	#ticket.transform.origin = Vector3.ZERO
	
func _deleteTicket(order: Order)-> void:
	print("start killing")
	for child in get_children():
		if child is OrderTicket&&child.order == order:
			child.queue_free()
			print("Delete complete!")
		else:
			continue
			
	
	#for i in OrderSpots.size():
		#var ticket = tickets.instantiate()
		#tickets.position = OrderSpots[i].position
