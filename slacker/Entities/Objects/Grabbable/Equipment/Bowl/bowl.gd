
extends Node3D

var dry_mix_added: bool = false
var water_added: bool = false
var eggs_added: bool = false

var ingredients_ready: bool = false
var batter_ready: bool = false
var pancake_cooked: bool = false

func _ready() -> void:
	$StaticBody3D/InteractableComponent.interacted.connect(_on_interacted)
	$StaticBody3D/InteractableComponent.hovered.connect($HighlightComponent.highlight)

	var mesh_node = $bowl
	print("BOWL READY REACHED MATERIAL CHECK")
	var material = mesh_node.get_active_material(0)

	print("Bowl mesh: ", mesh_node)
	print("Bowl material: ", material)

	if material is StandardMaterial3D:
		var highlight_shader = material.next_pass

		if highlight_shader is ShaderMaterial:
			#$HighlightComponent.SetShader(highlight_shader)
			print("Bowl highlight shader assigned!")
		else:
			print("Bowl Next Pass has no ShaderMaterial")
	else:
		print("Bowl has no active StandardMaterial3D")

func _on_interacted(_interactor: Node3D) -> void:
	print("Bowl interacted with!")

	if not ingredients_ready:
		print("Add all ingredients before mixing!")
		return

	if batter_ready:
		print("Batter is already mixed!")
		return

	batter_ready = true
	print("Pancake batter mixed!")


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
		ingredients_ready = true
		print("All pancake ingredients have been added!")


func _on_interactable_component_ready() -> void:
	pass
