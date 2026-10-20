extends Node
class_name HighlightComponent

var shader : ShaderMaterial

func SetShader(newShader : ShaderMaterial):
	shader = newShader

func highlight(_interactor, hovered: bool) -> void:
	if shader == null:
		print("Highlight shader is not assigned!")
		return

	var parent_name = str(get_parent().name) if get_parent() else "No Parent"
	if hovered:
		shader.set_shader_parameter("color", Color(1.0, 1.0, 0.0, 1.0))
		print("Highlight on: ", parent_name)
	else:
		shader.set_shader_parameter("color", Color(0.0, 0.0, 0.0, 1.0))
		print("Highlight off: ", parent_name)
