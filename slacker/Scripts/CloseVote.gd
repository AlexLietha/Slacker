extends Control
class_name CloseButton
signal closeUI()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Close_Button_Pressed() -> void:
	closeUI.emit()
