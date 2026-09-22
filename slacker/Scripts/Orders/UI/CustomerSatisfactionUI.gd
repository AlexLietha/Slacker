extends ColorRect

@export var sizeScale = 2.56
@export var gradient: Gradient

var happyBar = preload("res://UI/Satisfaction Rating/happy_bar_v1.png")
var sadBar = preload("res://UI/Satisfaction Rating/sad_bar_v1.png")

@export var barSprite : Sprite2D

var targetThreshold = 75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	OrderManager.CompletedOrder.connect(Update)
	Update(null)
	
func Update(_order : Order) -> void:
	var score = CustomerSatisfactionManager.GetScore()
	var barSize = score * sizeScale
	
	create_tween().tween_property(
		self,
		"size",
		Vector2(barSize, size.y),
		0.5
	)
	
	print(score)
	print(gradient.sample(score/100))
	
	create_tween().tween_property(
		self,
		"color",
		gradient.sample(score/100),
		0.5
	)
	
	if score >= 75:
		barSprite.texture = happyBar
	else:
		barSprite.texture = sadBar
