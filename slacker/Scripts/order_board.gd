extends Node3D

@export var OrderSpots: Array[Node3D]
#@export var tickets = preload("res://Scenes/OrderTicket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _spawnTicket() -> void:
	pass
	#for i in OrderSpots.size():
		#var ticket = tickets.instantiate()
		#tickets.position = OrderSpots[i].position
