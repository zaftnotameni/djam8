@tool
class_name HighlightsProblems extends Node

### the meta tag that the owner needs to carry to indicate a problem
@export var problem_meta : String = 'has_problems'
### what to show/hide if an interacting entity is in range
@export var canvas_item : CanvasItem

func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if owner.has_meta('has_problems') and owner.get_meta('has_problems'):
		canvas_item.show()
	else:
		canvas_item.hide()

func _enter_tree() -> void:
	set_process(not Engine.is_editor_hint())
	if not canvas_item: canvas_item = Resolve.at_by_meta(owner, 'problem_highlight', true)

func _ready() -> void:
	if Engine.is_editor_hint(): return
