extends RichTextLabel
class_name OrderElement

@export var order: Order

func _ready() -> void:
	pass

func UpdateText():
	text = order.get_current_step().description
