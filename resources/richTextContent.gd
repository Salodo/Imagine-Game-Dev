@tool
extends Content
class_name RichTextContent

@export var selection_enabled:bool = false:
	set(value):
		selection_enabled = value
		changed.emit()

@export_multiline var text:String = "":
	set(value):
		text = value
		changed.emit()
