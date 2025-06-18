@tool
extends Node2D

@onready var contents_container = %contents_container

const HORIZONTAL_LINE = preload("res://tool/article_builder/horizontal_line/horizontal_line.tscn")

func _ready():
	_on_article_changed()

@export var article: Article:
	set(value):
		if article != null:
			article.changed.disconnect(_on_article_changed)
		article = value
		
		if article != null:
			article.changed.connect(_on_article_changed)
		_on_article_changed()

func _on_article_changed():
	for i in contents_container.get_children():
		i.queue_free()
	
	if !article:
		return
	
	for i in article.contents:
		if i == null:continue
		hande_content(i)

func hande_content(content:Content):
	if content is RichTextContent:
		var new_lbl := RichTextLabel.new()
		new_lbl.bbcode_enabled = true
		new_lbl.fit_content = true
		print(content.selection_enabled)
		new_lbl.selection_enabled = content.selection_enabled
		new_lbl.append_text(content.text)
		contents_container.add_child(new_lbl)
	elif content is HorizontalLineContent:
		var new_hr = HORIZONTAL_LINE.instantiate()
		new_hr.custom_minimum_size.y = content.thickness
		new_hr.get_child(0).anchor_left = (1-content.width) / 2
		new_hr.get_child(0).anchor_right = 1-((1-content.width) / 2)
		new_hr.get_child(0).color = content.color
		contents_container.add_child(new_hr)
