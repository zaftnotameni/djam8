class_name OrbitalDecayLogic extends Node

const ORBITAL_DECAY_LOGIC_GROUP := 'orbital_decay_logic'

@onready var escape_velocity_marker : Control = %EscapeVelocity
@onready var orbit_height_bar: Control = %OrbitHeightBar
@onready var black_hole_marker : Control = %BlackHole
@onready var ship_indicator : Node2D = %ShipHudIndicator

@export var orbit_height : float = 11000.0 # in km
@export var multiplier: float = 50.0

var max_orbital_height : float = 21000.0 # in km
var min_orbital_height : float = 1000.0 # in km
var orbital_velocity : float = 8.0 # in km/s

var marker_top : Vector2
var marker_bottom : Vector2
var bar_height : float
var bar_center_x : float
var bonus: float = 0.0
var decay: float = 0.0
var saldo: float = 0.0

static func first() -> OrbitalDecayLogic:
	var tree := Engine.get_main_loop() as SceneTree
	return tree.get_first_node_in_group(ORBITAL_DECAY_LOGIC_GROUP) as OrbitalDecayLogic

func _unhandled_input(event: InputEvent) -> void:
	var key_event := event as InputEventKey
	if not key_event: return
	if not key_event.is_pressed(): return
	if key_event.keycode == KEY_F7: orbit_height += 1000
	if key_event.keycode == KEY_F6: orbit_height -= 1000

func _enter_tree() -> void:
	add_to_group(ORBITAL_DECAY_LOGIC_GROUP)

func _process(delta: float) -> void:
	var step_bonus : float = 0.0
	var step_decay : float = 0.0

	# for each device, check if the device has problems (meta[has_problems=true])
	#   - device with problems? adds the meta[orbital_decay] to the decay
	#   - device with NO problems? adds the meta[orbital_bonus] to the bonus
	# at the end, sum up all decay and bonus into a saldo sum (in km/s)
	# that is multipled by delta to get a value in km/frame and finally added to the orbital height
	for hi: HighlightsInteractions in HighlightsInteractions.all():
		if hi.owner.has_meta('has_problems') and hi.owner.get_meta('has_problems'):
			step_decay += hi.owner.get_meta('orbital_decay') if hi.owner.has_meta('orbital_decay') else 0.0

		if not hi.owner.has_meta('has_problems') or not hi.owner.get_meta('has_problems'):
			step_bonus += hi.owner.get_meta('orbital_bonus') if hi.owner.has_meta('orbital_bonus') else 0.0

	bonus = step_bonus * multiplier
	decay = step_decay * multiplier
	saldo = (bonus - decay)
	orbit_height += saldo * delta

	marker_top = orbit_height_bar.get_rect().position
	marker_bottom = marker_top + orbit_height_bar.get_rect().size
	bar_height = marker_top.y - marker_bottom.y
	bar_center_x = (marker_top.x + orbit_height_bar.get_rect().size.x) + 30
	orbital_velocity = sqrt(640000.0 / orbit_height)

	var visual_height := remap(orbit_height, min_orbital_height, max_orbital_height, marker_bottom.y, marker_top.y)
	ship_indicator.global_position = ship_indicator.global_position.move_toward(Vector2(bar_center_x, visual_height), delta * 1000)

# escape velocity formula: v = sqrt(2GM/R)
# orbital velocity formula: v = sqrt(GM/R)

