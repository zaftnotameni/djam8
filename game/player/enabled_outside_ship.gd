### Enables the parent only outside the ship
class_name EnabledOutsideShip extends Node

@export var target : Node
@export var interior_exterior_tracker : InteriorExteriorTracker

func update_target_processing(where:InteriorExteriorTracker.InteriorExterior):
	target.process_mode = Node.PROCESS_MODE_DISABLED if where != InteriorExteriorTracker.InteriorExterior.EXTERIOR else Node.PROCESS_MODE_INHERIT
	# if targetting particles, stop emitting if not outside
	var particles : CPUParticles2D = target as CPUParticles2D
	if particles:
		if where == InteriorExteriorTracker.InteriorExterior.EXTERIOR:
			particles.visible = true
		if where != InteriorExteriorTracker.InteriorExterior.EXTERIOR:
			particles.visible = false
			particles.emitting = false
	if where == InteriorExteriorTracker.InteriorExterior.EXTERIOR:
		if target.has_method('on_enable'): target.on_enable()
	if where != InteriorExteriorTracker.InteriorExterior.EXTERIOR:
		if target.has_method('on_disable'): target.on_disable()

func _enter_tree() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	if not target: target = get_parent()

func _ready() -> void:
	if not interior_exterior_tracker : interior_exterior_tracker = InteriorExteriorTracker.first()
	update_target_processing(interior_exterior_tracker.where)
	interior_exterior_tracker.sig_where_changed.connect(update_target_processing)
