extends Control

signal _on_start
signal _on_end
signal _on_success
signal _on_fail_low
signal _on_fail_high

@onready var meter: TextureRect = $Meter
@onready var slider: TextureRect = $Meter/Slider
@onready var left: Marker2D = $Meter/left
@onready var right: Marker2D = $Meter/right
@onready var safe_left: Marker2D = $Meter/safe_left
@onready var safe_right: Marker2D = $Meter/safe_right

@export var speed: int = 2000 #speed the slider moves at
var direction: int = 1 #1 = right, -1 = left


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#determines starting direction based on whether 0 or 1
	if Time.get_ticks_msec() % 2 == 1:
		direction = -1
	
	#randomizes starting pos based on range
	var random_int = randi_range(left.position.x, right.position.x - slider.size.x)
	slider.position.x = random_int
	
	#signal that minigame has instantiated
	_on_start.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#turn slider around if outside bounds
	if slider.position.x <= left.position.x:
		direction = 1
	elif slider.position.x + slider.size.x >= right.position.x:
		direction = -1
	
	#move slider
	slider.position.x += speed * delta * direction
	
	#TODO
	#get angle of egg to bowl to set meter.rotation (clamp -90 to 0)
	

#check slider's position and win/lose minigame
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.is_action("interact"):
			if slider.position.x >= safe_left.position.x && slider.position.x + slider.size.x <= safe_right.position.x:
				print("green")
				_on_success.emit()
			elif slider.position.x >= left.position.x && slider.position.x + slider.size.x <= safe_left.position.x:
				print("too low")
				_on_fail_low.emit()
			elif slider.position.x >= safe_right.position.x && slider.position.x + slider.size.x <= right.position.x:
				print("too high")
				_on_fail_high.emit()
			_on_end.emit()
			queue_free()

#TEST
func print_start():
	print("egg game start")
func print_end():
	print("egg game end")
	queue_free()
func print_win():
	print("egg game won")
func print_loss():
	print("egg game lost")


#NOTES AND OUTDATED CODE
#input in _process, just in case I did it wrong for input
#if Input.is_action_just_pressed("interact"):
		#if slider.position.x >= safe_left.position.x && slider.position.x + slider.size.x <= safe_right.position.x:
			#print("green")
			#_on_end.emit()
			#_on_success.emit()
		#else:
			#print("white")
			#_on_end.emit()
			#_on_fail.emit()
