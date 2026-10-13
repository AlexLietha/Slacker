extends Resource
class_name TaskStep

enum StepType{
	Deliver,
	Cook,
	Retrieve
}

@export var description: String
@export var type: StepType

# Used depending on the step type
@export var target_id: String
@export var required_amount: int = 1

var current_amount: int = 0
var completed: bool = false


func progress(amount: int = 1) -> void:
	if completed:
		return

	current_amount += amount

	if current_amount >= required_amount:
		current_amount = required_amount
		completed = true

func matches_event(event_type: String, event_target: String) -> bool:
	var expected_type := ""

	match type:
		StepType.Deliver:
			expected_type = "Deliver"

		StepType.Retrieve:
			expected_type = "Retrieve"

		StepType.Cook:
			expected_type = "Cook"


	return expected_type == event_type and target_id == event_target
