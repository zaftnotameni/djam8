class_name AutoloadConfig extends Node

var screen_height : int = ProjectSettings.get_setting('display/window/size/viewport_height')
var screen_width : int = ProjectSettings.get_setting('display/window/size/viewport_width')

var menu_background_color : Color = Color('#311b27')

var player_data : PlayerData

func _enter_tree() -> void:
	player_data = PlayerData.load_from_file_or_create_file()
