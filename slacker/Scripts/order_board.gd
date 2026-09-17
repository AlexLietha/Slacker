extends Node3D
class_name Order_Board

@export var OrderSpots: Array[Node3D]
var ticket_scene : PackedScene = preload("res://Scenes/order_ticket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	OrderManager.StartedOrder.connect(_spawnTicket)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _spawnTicket(order: Order) -> void:
	
	var label = OrderTicket.new()
	print("Making Ticket")
	var ticket = ticket_scene.instantiate()
	label.Set_Text(order.GetEntree().GetName())
	print(order.GetEntree().GetName()+" On ticket")
	print("Ticket Made")
	#ticket.transform.origin = Vector3.ZERO
	add_child(ticket)
	
	
	#for i in OrderSpots.size():
		#var ticket = tickets.instantiate()
		#tickets.position = OrderSpots[i].position
