extends Control
class_name VotePopUpUI

func _ready() -> void:
	hide_vote_pop_up()
	
func animate_ui() -> void:
	var tween = get_tree().create_tween()
	self.position = Vector2(0,-150)
	tween.tween_property(self, "position", Vector2(0, 40), 2.0)
	tween.tween_property(self, "position", Vector2(), 5.0)
	tween.tween_property(self, "position", Vector2(0, -200), 2.0)
	tween.tween_callback(hide_vote_pop_up)


func has_been_voted() -> void:
	print("you have been voted for")
	self.visible = true
	#await get_tree().create_timer(3.0).timeout
	animate_ui()
	#hide_vote_pop_up()

func hide_vote_pop_up() -> void:
	self.visible = false
	print("vote pop up ui hidden")
