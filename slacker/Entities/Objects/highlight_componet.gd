extends Node
class_name HighlightComponent

var shader : ShaderMaterial

var debug_print_source = "[highlight_component.gd] - "

func set_shader(newShader : ShaderMaterial):
	shader = newShader

func highlight(_interactor, hovered: bool) -> void:
	if shader == null:
		print(debug_print_source + "Highlight shader is not assigned!")
		return

	var parent_name = str(get_parent().name) if get_parent() else "No Parent"
	if hovered:
		shader.set_shader_parameter("color", Color(1.0, 1.0, 0.0, 1.0))
		print(debug_print_source, "Highlight on: ", parent_name)
	else:
		shader.set_shader_parameter("color", Color(0.0, 0.0, 0.0, 1.0))
		print(debug_print_source, "Highlight off: ", parent_name)
