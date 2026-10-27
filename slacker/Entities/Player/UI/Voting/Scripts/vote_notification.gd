# Aidan Musil
extends Control
class_name VotePopUpUI

var current_tween: Tween
var vote = 0
var play_ani = true
@onready var strike_icons_off = [$Strike1Off, $Strike2Off, $Strike3Off]
@onready var strike_icons_on = [$Strike1On, $Strike2On, $Strike3On]
@export var player_icon: TextureRect

var debug_print_source = "[vote_notification.gd] - "

func _ready() -> void:
	hide_vote_pop_up()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debugKey"):
		print(debug_print_source + "debug key called")
		has_been_voted()

func animate_ui() -> void:
	if current_tween and current_tween.is_running():
		current_tween.kill()
	
	position = Vector2(0, -150)
	visible = true
	
	current_tween = create_tween()
	
	# slide in with a slight bounce, wait n seconds, then slide out
	current_tween.tween_property(self, "position", Vector2(0, 40), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT) 
	current_tween.tween_interval(3.0)
	current_tween.tween_property(self, "position", Vector2(0, -200), 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	current_tween.tween_callback(hide_vote_pop_up)

func has_been_voted() -> void:
	print(debug_print_source + "You have been voted for")
	animate_ui()
	add_strike()

func add_strike() -> void:
	if vote >= strike_icons_off.size() or vote >= strike_icons_on.size():
		print(debug_print_source + "Maximum strikes reached!")
		return
		
	if strike_icons_off[vote] == null or strike_icons_on[vote] == null:
		print(debug_print_source + "Strike icon is null at index: " + str(vote))
		return
		
	print(debug_print_source + "X added")
	
	strike_icons_off[vote].hide()
	strike_icons_on[vote].show()
	
	vote += 1

func hide_vote_pop_up() -> void:
	visible = false
	print(debug_print_source + "Vote pop up ui hidden")
	
func set_notify_face(face:CompressedTexture2D)->void:
	player_icon.texture = face
