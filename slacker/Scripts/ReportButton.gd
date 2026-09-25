extends TextureButton

var counter: int = 0
@export var X1: TextureRect
@export var X2: TextureRect
@export var X3: TextureRect
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if(counter == 0):
		X1.visible = true
	elif(counter == 1):
		X2.visible = true
	else:
		X3.visible = true
	
	counter = counter + 1;
	
