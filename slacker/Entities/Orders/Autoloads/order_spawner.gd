extends Node

@export var minOrderWaitTime := 1.0
@export var maxOrderWaitTime := 10.0

var timeTilNextOrder = 10.0
var listOfEntres : Array[Entree] = [preload("uid://djbrti3q0enq"), preload("uid://du8ppeqhq88dr")]
var canSpawnNextOrder = true
signal NewOrder(order: Order)
var rng = RandomNumberGenerator.new()

var debug_print_source = "[order_spawner.gd] - "

func create_order():
	var selected_entree: Entree = listOfEntres.pick_random()
	var new_order: Order = Order.new()
	new_order.set_entree(selected_entree)

	NewOrder.emit(new_order)
	OrderManager.start_order(new_order)

func get_new_signal_order() -> Signal:
	return NewOrder
	
func spawn_orders():
	print(debug_print_source + "Spawn order called")
	await get_tree().create_timer(timeTilNextOrder).timeout
	timeTilNextOrder = rng.randf_range(minOrderWaitTime, maxOrderWaitTime)
	
	if canSpawnNextOrder:
		create_order()
		spawn_orders()
		
func start_spawning_order():
	canSpawnNextOrder = true
	spawn_orders()
	
func stop_spawning_order():
	canSpawnNextOrder = false
