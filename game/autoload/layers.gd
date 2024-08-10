class_name AutoloadLayers extends Node2D

@onready var game : CanvasLayer = layer_game()
@onready var background : CanvasLayer = layer_background()
@onready var hud : CanvasLayer = layer_hud()
@onready var menu : CanvasLayer = layer_menu()

func layer_game() -> CanvasLayer: return get_tree().get_first_node_in_group('game_layer')
func layer_background() -> CanvasLayer: return get_tree().get_first_node_in_group('background_layer')
func layer_hud() -> CanvasLayer: return get_tree().get_first_node_in_group('hud_layer')
func layer_menu() -> CanvasLayer: return get_tree().get_first_node_in_group('menu_layer')
