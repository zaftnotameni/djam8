class_name GeneratesProblems extends Node

@export var every_n_seconds : float = 10

var elapsed : float = 0.0

func generate_problem():
	var problem_highlighters := get_tree().get_nodes_in_group(HighlightsProblems.HIGHLIGHTS_PROBLEMS_GROUP_NAME)
	var problem_highlighter : HighlightsProblems = null

	if problem_highlighters:
		problem_highlighter = problem_highlighters.filter(HighlightsProblems.has_no_problems).pick_random() as HighlightsProblems

	if problem_highlighter:
		problem_highlighter.owner.set_meta('has_problems', true)

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed >= every_n_seconds:
		elapsed = 0.0
		generate_problem()
