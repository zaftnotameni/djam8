class_name ProblemIndicators extends Node2D

@export var indicator_color : Color = Color.ORANGE_RED

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var camera := get_viewport().get_camera_2d()
	if not camera: return
	var viewport_size: Vector2 = camera.get_viewport_rect().size / camera.zoom
	var max_distance : float = viewport_size.y * 0.5 * 0.9
	var max_distance_squared : float = max_distance ** 2
	var camera_global_position := Vector2(camera.global_position.x, camera.global_position.y)
	for problem:Node2D in HighlightsProblems.problems.keys():
		var problem_global_position := Vector2(problem.global_position.x, problem.global_position.y)
		var direction: Vector2 = (problem_global_position - camera_global_position).normalized()
		var indicator_position: Vector2 = direction * max_distance
		if max_distance_squared > camera_global_position.distance_squared_to(problem_global_position):
			pass
		else:
			draw_triangle_indicator(camera_global_position + indicator_position, direction)

func draw_triangle_indicator(indicator_position: Vector2, direction: Vector2):
	var size: float = 16.0

	var p1: Vector2 = indicator_position
	var p2: Vector2 = indicator_position - direction.rotated(-PI/4) * size
	var p3: Vector2 = indicator_position - direction.rotated(PI/4) * size

	draw_polygon([p1, p2, p3], [indicator_color])

