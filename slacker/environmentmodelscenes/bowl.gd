extends Node3D

var dry_mix_added: bool = false
var water_added: bool = false
var eggs_added: bool = false
var batter_ready: bool = false

func _ready() -> void:
	$InteractableComponent.interacted.connect(_on_interacted)


func _on_interacted(_interactor: Node3D) -> void:
	print("Bowl interacted with!")

func add_ingredient(ingredient: String) -> void:
	match ingredient:
		"dry_mix":
			dry_mix_added = true
		"water":
			water_added = true
		"eggs":
			eggs_added = true

	check_batter_ready()


func check_batter_ready() -> void:
	if dry_mix_added && water_added && eggs_added:
		batter_ready = true
		print("Pancake batter is ready!")
