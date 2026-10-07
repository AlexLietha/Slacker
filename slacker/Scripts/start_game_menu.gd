extends CanvasLayer

@onready var button_start: Button = $PanelContainer/MarginContainer/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_start.pressed.connect(Network.start_game)
	pass # Replace with function body.
