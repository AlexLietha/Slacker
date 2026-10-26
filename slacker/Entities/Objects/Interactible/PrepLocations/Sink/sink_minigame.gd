class_name SinkMinigame extends Node3D

@export var initial_placement: Node3D
@export var finished_placement: Node3D

var in_minigame: bool = false
var item_to_clean
var dirty_componenent: DirtyComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && in_minigame:
		dirty_componenent.clean(get_tree().get_root().get_process_delta_time())
		if !dirty_componenent.is_dirty:
			in_minigame = false
			item_to_clean.place(finished_placement)


func play_minigame(item: GrabbableObject) -> void:
	in_minigame = true
	item_to_clean = item
	dirty_componenent = item.get_node("DirtyComponent")
	item.place(initial_placement)
