@tool
class_name HighlightsProblems extends Node

const HIGHLIGHTS_PROBLEMS_GROUP_NAME := 'highlights_problems'

static var problems : Dictionary = {}

### the meta tag that the owner needs to carry to indicate a problem
@export var problem_meta : String = 'has_problems'
### what to show/hide if an interacting entity is in range
@export var canvas_item : CanvasItem

static func has_no_problems(highlights_problems:HighlightsProblems) -> bool:
	return not highlights_problems.owner.has_meta('has_problems') or not highlights_problems.owner.get_meta('has_problems')

static func has_problems(highlights_problems:HighlightsProblems) -> bool:
	return highlights_problems.owner.has_meta('has_problems') and highlights_problems.owner.get_meta('has_problems')

func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if has_problems(self):
		canvas_item.show()
		problems[owner] = true
	else:
		canvas_item.hide()
		if problems.has(owner): problems.erase(owner)

func _exit_tree() -> void:
	if problems.has(owner): problems.erase(owner)

func _enter_tree() -> void:
	set_process(not Engine.is_editor_hint())
	add_to_group(HIGHLIGHTS_PROBLEMS_GROUP_NAME)

func _ready() -> void:
	if not canvas_item: canvas_item = Resolve.at_by_meta(owner, 'problem_highlight', true)
	if Engine.is_editor_hint(): return
