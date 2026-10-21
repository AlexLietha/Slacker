extends ColorRect

var size_scale = 2.65
@export var gradient: Gradient

var happyBar = preload("uid://cjg13nwx8uky3")
var sadBar = preload("uid://dwexlgu75s2hg")

@export var barSprite : Sprite2D

var targetThreshold = 75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size_scale = size.x/100
	OrderManager.CompletedOrder.connect(update)
	update(null)
	
func update(_order : Order) -> void:
	var score = CustomerSatisfactionManager.get_score()
	var barSize = score * size_scale
	
	create_tween().tween_property(
		self,
		"size",
		Vector2(barSize, size.y),
		0.5
	)
	
	#print(score)
	#print(gradient.sample(score/100))
	
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
