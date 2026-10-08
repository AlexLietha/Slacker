extends CanvasLayer

@onready var button_start: Button = $PanelContainer/MarginContainer/VBoxContainer/Start
@onready var button_slacker: Button = $PanelContainer/MarginContainer/VBoxContainer/Slacker

const PLAYER = preload("res://Scripts/playerMovement.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_start.pressed.connect(Network.start_game)
	var _player = PLAYER.new()
	button_slacker.pressed.connect(_player.updateMaterialColor)
