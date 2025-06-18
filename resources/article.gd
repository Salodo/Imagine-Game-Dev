@tool
extends Resource
class_name Article



@export var contents:Array[Content] = []:
	set(value):
		contents = value
		for i in value:
			if i == null:continue
			
			if !i.is_connected("changed",_content_changed):
				i.changed.connect(_content_changed)
		# Emit a signal when the property is changed.
		changed.emit()

func _content_changed():
	changed.emit()
