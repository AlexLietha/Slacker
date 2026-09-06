extends Node


var all_orders : Array[Order] = [preload("res://Orders & Tasks/Orders/Burger.tres")]
var canSpawn = true


func _ready() -> void:
	StartSpawningOrder()

func NewOrder():
	var new_order = all_orders.pick_random()
	OrderManager.start_order(new_order)
	
func StartSpawningOrder():
	canSpawn = true
	while canSpawn:
		
		await get_tree().create_timer(5).timeout
		NewOrder()
		
		
func StopSpawningOrder():
	canSpawn = false
	
