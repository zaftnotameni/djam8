@tool
class_name HighlightsInteractions extends Node

const HIGHLIGHTS_INTERACTIONS_GROUP_NAME := 'highlights_interactions'

### the meta tag that interacting entities need to carry to trigger this
@export var source_meta : String = 'player_interaction'
### determines the range to detect interacting entities
@export var area : Area2D
### what to show/hide if an interacting entity is in range
@export var canvas_item : CanvasItem

var is_highlighting : bool = false

func _enter_tree() -> void:
	if not area: area = Resolve.at_by_meta(owner, 'object_interaction', true)
	if not canvas_item: canvas_item = Resolve.at_by_meta(owner, 'interaction_highlight', true)
	add_to_group(HIGHLIGHTS_INTERACTIONS_GROUP_NAME)

func unhighlight(highlight_others:bool=false):
	if highlight_others:
		var found : bool = false
		for hi : HighlightsInteractions in get_tree().get_nodes_in_group(HIGHLIGHTS_INTERACTIONS_GROUP_NAME):
			if found: break
			if hi:
				for other:Area2D in hi.area.get_overlapping_areas():
					if other.has_meta(source_meta) and other.get_meta(source_meta):
						hi.highlight()
						found = true
						break
	is_highlighting = false
	canvas_item.hide()

func highlight(unhighlight_others:bool=false):
	if unhighlight_others:
		for hi : HighlightsInteractions in get_tree().get_nodes_in_group(HIGHLIGHTS_INTERACTIONS_GROUP_NAME):
			if hi: hi.unhighlight()
	is_highlighting = true
	canvas_item.show()

func on_area_entered(other:Area2D):
	if other.has_meta(source_meta) and other.get_meta(source_meta):
		# when highliting one interaction, hide other interactions, so only one interaction target can be active at once
		highlight(true)

func on_area_exited(other:Area2D):
	if other.has_meta(source_meta) and other.get_meta(source_meta):
		# when unhighliting one interaction, potentially restore another interaction if they are overlapping
		unhighlight(true)

func _ready() -> void:
	if Engine.is_editor_hint(): return
	area.area_entered.connect(on_area_entered)
	area.area_exited.connect(on_area_exited)
