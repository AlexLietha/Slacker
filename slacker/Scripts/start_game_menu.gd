extends CanvasLayer

@onready var button_start: Button = $PanelContainer/MarginContainer/VBoxContainer/Button
const TIMER = preload("res://Scripts/round_timer.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_timer = TIMER.new()
	button_start.pressed.connect(Network.start_game)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
