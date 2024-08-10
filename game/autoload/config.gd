class_name AutoloadConfig extends Node

var screen_height : int = ProjectSettings.get_setting('display/window/size/viewport_height')
var screen_width : int = ProjectSettings.get_setting('display/window/size/viewport_width')

var player_width : float = 16
var player_height : float = 16

# configuration block for movement inside the ship
var player_inside_ship_initial_movement_speed : float = 10 * player_width # px/s
var player_inside_ship_gravity_acceleration: float = 10 * player_height # px/s/s

# configuration block for movement outside the ship
var player_outside_ship_acceleration : float = 10 * player_height # px/s/s
var player_outside_ship_max_speed : float = 100 * player_height # px/s/s

var player_data : PlayerData

func _enter_tree() -> void:
	# loads player data from a file, right now this only contains audio volume preferences
	player_data = PlayerData.load_from_file_or_create_file()
