class_name AutoloadConfig extends Node

var player_width : float = 16
var player_height : float = 16

var player_inside_ship_initial_movement_speed : float = 10 * player_width
var player_inside_ship_gravity_acceleration: float = 10 * player_height

var player_outside_ship_acceleration : float = 10 * player_height
var player_outside_ship_decceleration : float = 0 * player_height
var player_outside_ship_max_speed : float = 100 * player_height

var screen_height : int = ProjectSettings.get_setting('display/window/size/viewport_height')
var screen_width : int = ProjectSettings.get_setting('display/window/size/viewport_width')

var menu_background_color : Color = Color('#311b27')

var player_data : PlayerData

func _enter_tree() -> void:
	player_data = PlayerData.load_from_file_or_create_file()
