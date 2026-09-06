extends Resource
class_name Order

@export var order_id: String
@export var title: String
@export_multiline var description: String

@export var steps: Array[TaskStep] = []

var instance_id: String = ""
var current_step_index: int = 0
var completed: bool = false


func get_current_step() -> TaskStep:
	if completed:
		return null

	if current_step_index >= steps.size():
		return null

	return steps[current_step_index]


func advance() -> void:
	if completed:
		return

	current_step_index += 1

	if current_step_index >= steps.size():
		completed = true


func check_progress() -> void:
	print("Checked Order Progress")
	var step := get_current_step()

	if step == null:
		return

	if step.completed:
		advance()
