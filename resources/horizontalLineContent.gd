@tool
extends Content
class_name HorizontalLineContent

@export var thickness := 1.0:
	set(value):
		thickness = value
		changed.emit()

##The width of the horizontal line should be. in percentage
@export_range(0,1,0.1) var width := 1.0:
	set(value):
		width = value
		changed.emit()

@export var color:Color = Color.WHITE:
	set(value):
		color = value
		changed.emit()
