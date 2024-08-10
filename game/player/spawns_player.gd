class_name SpawnsPlayer extends Marker2D

const SPAWNS_PLAYER_GROUP_NAME := 'spawns_player'

@export var scene : PackedScene
@export var spawns_on_ready : bool = false

var player : Node2D

func kill_and_respawn_player():
	if player and not player.is_queued_for_deletion():
		player.queue_free()
		await player.tree_exited
	spawn_player.call_deferred()

func on_player_tree_exiting():
	player = null

func spawn_player():
	player = scene.instantiate() as Node2D
	player.global_position = global_position
	player.tree_exiting.connect(on_player_tree_exiting)
	Layers.game.add_child(player)

func _ready() -> void:
	if spawns_on_ready:
		spawn_player()

func _enter_tree() -> void:
	add_to_group(SPAWNS_PLAYER_GROUP_NAME)
	if not scene: scene = load('res://game/player/player.tscn')

static func first() -> SpawnsPlayer:
	var tree := Engine.get_main_loop() as SceneTree
	return tree.get_first_node_in_group(SPAWNS_PLAYER_GROUP_NAME) as SpawnsPlayer
