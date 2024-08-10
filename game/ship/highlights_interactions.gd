@tool
class_name HighlightsInteractions extends Node

### the meta tag that interacting entities need to carry to trigger this
@export var source_meta : String = 'player_interaction'
### determines the range to detect interacting entities
@export var area : Area2D
### what to show/hide if an interacting entity is in range
@export var canvas_item : CanvasItem

func _enter_tree() -> void:
	if not area: area = Resolve.at_by_meta(owner, 'object_interaction', true)
	if not canvas_item: canvas_item = Resolve.at_by_meta(owner, 'interaction_highlight', true)

func on_area_entered(other:Area2D):
	if other.has_meta(source_meta) and other.get_meta(source_meta): canvas_item.show()

func on_area_exited(other:Area2D):
	if other.has_meta(source_meta) and other.get_meta(source_meta): canvas_item.hide()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	area.area_entered.connect(on_area_entered)
	area.area_exited.connect(on_area_exited)
