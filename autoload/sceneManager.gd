extends Node

const ARTICLE_SCENE = preload("res://tool/article_builder/article_builder.tscn")

func load_article_from_resource(path:String):
	var article_res = load(path)
	get_tree().change_scene_to_packed(ARTICLE_SCENE)
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	get_tree().current_scene.article = article_res
