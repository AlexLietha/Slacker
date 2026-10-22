class_name DirtyComponent extends Node3D

@export var is_dirty : bool = false

@onready var dirt: Decal = $Dirt

var dirt_visible:= Color(1.0, 1.0, 1.0, 1.0)
var dirt_hidden:= Color(1.0, 1.0, 1.0, 0.0)
var cleaning_speed: float = 0.1


func _ready() -> void:
	if is_dirty:
		dirt.modulate = dirt_visible
	else:
		dirt.modulate = dirt_hidden

# called by the sink
# sets the dirt decal to be more transparent over time (delta)
func clean(delta: float) -> void:
	if dirt.modulate.a <= (dirt_hidden.a + 0.4) && is_dirty:
		is_dirty = false
		dirt.modulate = dirt_hidden
	dirt.modulate.a -= delta * cleaning_speed
