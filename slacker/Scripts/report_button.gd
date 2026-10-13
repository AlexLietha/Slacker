extends TextureButton
class_name PlayerIcon

var counter: int = 0
signal buttonPressed(counter: int,Xs:Array[TextureRect])
@export var Xs: Array[TextureRect]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	#var id = get_instance_id()
	print("emit")
	buttonPressed.emit(counter,Xs)
	print("emitted")
	
func CounterSetter(newCounter: int)->void :
	counter = newCounter
	
