extends Node
class_name HighlightComponent

var shader : ShaderMaterial

func SetShader(newShader : ShaderMaterial):
	shader = newShader

func highlight(_interactor, hovered: bool)->void:
	if hovered:
		shader.set_shader_parameter("color", Color(1.0, 1.0, 0.0, 1.0))

	else:
		shader.set_shader_parameter("color", Color(0.0, 0.0, 0.0, 1.0))
