class_name RopesToShip extends Node

var points: Array[Vector2] = [Vector2.ZERO, Vector2.ZERO]

@export var rope_length: float = 600
@export var line: Line2D
@export var target: Node2D
@export var attachment_point: Node2D
@export var tracker: InteriorExteriorTracker

var static_body : StaticBody2D

func _enter_tree() -> void:
	static_body = StaticBody2D.new()
	static_body.collision_mask = 0
	static_body.collision_layer = 0
	var point_count := 6
	var angle := deg_to_rad(360.0 / point_count)
	for i in point_count:
		var col := CollisionShape2D.new()
		var seg := SegmentShape2D.new()
		col.shape = seg
		seg.a = Vector2(rope_length * cos(angle * i), rope_length * sin(angle * i))
		seg.b = Vector2(rope_length * cos(angle * (i + 1)), rope_length * sin(angle * (i + 1)))
		static_body.global_position = attachment_point.global_position
		static_body.add_child(col)
	add_child.call_deferred(static_body)

func _ready() -> void:
	if not target: target = SpawnsPlayer.first().player
	if not tracker: tracker = InteriorExteriorTracker.first()
	if target: points[0] = target.global_position
	update_rope_visual()

func _physics_process(delta: float) -> void:
	if not target: target = SpawnsPlayer.first().player
	if not tracker: tracker = InteriorExteriorTracker.first()
	if not tracker: return
	if not target: return

	match tracker.where:
		InteriorExteriorTracker.InteriorExterior.INTERIOR:
			static_body.collision_mask = 0
			static_body.collision_layer = 0
			if attachment_point: points[0] = attachment_point.global_position
		InteriorExteriorTracker.InteriorExterior.EXTERIOR:
			static_body.collision_mask = 1
			static_body.collision_layer = 1
			if target: points[0] = target.global_position

	if attachment_point: points[-1] = attachment_point.global_position
	simulate_rope(delta)
	update_rope_visual()

func simulate_rope(_delta: float):
	pass

func update_rope_visual():
	line.points = PackedVector2Array(points)
