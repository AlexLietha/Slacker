class_name Player
extends Node3D

@export var player_name := "PlayerName" # temp name
@export var interactionRayCast : RayCast3D
@export var grabbedItem : Node3D
@export var vote_pop_up_ui : Control

var name_generator : NameGenerator = preload("uid://dleg4tpvbkn2q").new()
var debug_print_source = "[player.gd] - "

@onready var vote_ui := $VotingBoard
@onready var player_overhead_name: Label3D = $PlayerMovement/PlayerName
@onready var camera := $PlayerMovement/PlayerNeckPivot/Camera
@onready var player_mesh := $PlayerMovement/PlayerMesh

# Multiplier stuff. Having this code uncommented when testing breaks the player
func _enter_tree() -> void:
	print(debug_print_source + "Player enter tree " + name)
	#print(debug_print_source + "Authroity: " + str(get_multiplayer_authority()))
	#set_multiplayer_authority(name.to_int())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)
		camera.current = false
		return
	
	camera.current = true
	print(debug_print_source + "Player Auth: " + str(get_multiplayer_authority()))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop"):
		if has_grabbed_item():
			get_grabbed_item().drop()
		pass


func set_player_name() -> void:
	player_name = name_generator.pick_random_name()
	player_overhead_name.text = player_name
	print(debug_print_source + "Player Name: " + player_name)

func get_player_name() -> String:
	return player_name


## this can stay now, but should be moved by Alex when he redoes interaction stuff
func get_grabbed_item() -> GrabbableObject:
	if not has_grabbed_item():
		return null
	return grabbedItem.get_child(0)

func has_grabbed_item() -> bool:
	return grabbedItem.get_child_count() == 1
