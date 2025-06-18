extends CanvasLayer

@onready var article_container:HFlowContainer = %ArticleContainer

#			Article structure
#==========================================
# -> settings.json
# -> Icon.png
#==========================================

#Loads a single article card from any directory
func load_article(dir:String) -> bool:
	
	if not DirAccess.dir_exists_absolute(dir):
		printerr("Cannot load article. Directory does not exist : "+dir)
		return false
	if not FileAccess.file_exists(dir+"/settings.json"):
		printerr("Cannot load article. Settings.json file does not exist in directory "+dir)
		return false
	
	var settings_file = FileAccess.open(dir+"/settings.json",FileAccess.READ)
	var settings_text : String = settings_file.get_as_text()

	var json:JSON = JSON.new()
	var error = json.parse(settings_text)

	var settings:Dictionary = {}

	if error == OK:
		settings = json.data
	else:
		printerr("Failed to read json file settings.json for "+dir+" : "+json.get_error_message())
		return false
	
	var new_article_card = load("uid://1nvh1p6v3eim").instantiate() #Article card scene
	article_container.add_child(new_article_card)
	new_article_card.setup(settings, dir)

	return true

#Goes through the article folder and adds a card for every article
func load_articles():
	var article_folders:PackedStringArray = DirAccess.get_directories_at("res://articles")
	
	for i in article_folders:
		load_article("res://articles/"+i)

func _ready():
	
	load_articles()
