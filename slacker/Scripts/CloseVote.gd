extends Control
class_name CloseButton
signal closeUI()

func Close_Button_Pressed() -> void:
	closeUI.emit()
