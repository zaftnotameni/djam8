### Enables the parent only inside the ship
class_name EnabledInsideShip extends Node

@export var target : Node
@export var interior_exterior_tracker : InteriorExteriorTracker

func update_target_processing(where:InteriorExteriorTracker.InteriorExterior):
	target.process_mode = Node.PROCESS_MODE_DISABLED if where != InteriorExteriorTracker.InteriorExterior.INTERIOR else Node.PROCESS_MODE_INHERIT

func _enter_tree() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	if not target: target = get_parent()

func _ready() -> void:
	if not interior_exterior_tracker : interior_exterior_tracker = InteriorExteriorTracker.first()
	update_target_processing(interior_exterior_tracker.where)
	interior_exterior_tracker.sig_where_changed.connect(update_target_processing)
