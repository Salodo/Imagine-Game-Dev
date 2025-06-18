extends PanelContainer

@onready var lbl:Label = $VBoxCard/Label
@onready var vbox_card:VBoxContainer = $VBoxCard
@onready var texture = $VBoxCard/texture

const ANIMATION_TIME = 0.1
var article_path:String = ""
var article_resource_path:String = ""

func setup(settings:Dictionary,article_path:String):
	if not settings.has("name"):
		printerr("Settings.json for "+article_path+" does not contain name property.")
		return
	if not settings.has("article"):
		printerr("Settings.json for "+article_path+" does not contain an article resource.")
		return
	
	var name:String = settings.name
	article_resource_path = article_path+"/"+settings.article
	
	if settings.has("icon"):
		var icon = load(article_path+"/"+settings.icon)
		texture.texture = icon
	elif FileAccess.file_exists(article_path+"/icon.png"):#CHECK IF ICON WITH DEFAULT NAME EXISTS
		var icon = load(article_path+"/icon.png")
		texture.texture = icon
	
	lbl.text = name
	self.article_path = article_path


func _on_mouse_entered():
	var tween_scale := get_tree().create_tween()
	var tween_rotation := get_tree().create_tween()

	tween_scale.tween_property(self,"scale",Vector2.ONE*1.05,ANIMATION_TIME)
	tween_rotation.tween_property(self,"rotation",-PI/76,ANIMATION_TIME)


func _on_mouse_exited():
	var tween_scale := get_tree().create_tween()
	var tween_rotation := get_tree().create_tween()

	tween_scale.tween_property(self,"scale",Vector2.ONE,ANIMATION_TIME)
	tween_rotation.tween_property(self,"rotation",0,ANIMATION_TIME)


func _on_click_detection_pressed():
	SceneManager.load_article_from_resource(article_resource_path)
