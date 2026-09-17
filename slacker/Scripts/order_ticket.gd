extends Area3D
class_name OrderTicket

@export var label3d: Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Set_Text("Press E To Start")
	position = Vector3(1,1,1)
	print(position)
	#OrderList.AddOrder()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func Set_Text(newText: String) -> void:
	if Label3D:
		label3d.text = newText
