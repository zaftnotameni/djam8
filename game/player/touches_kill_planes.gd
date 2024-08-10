### if the player touches a kill plane, it will respawn
class_name TouchesKillPlanes extends Node

@export var player : CharacterBody2D
@export var area : Area2D

func on_body_entered(body:Node2D):
	if body.has_meta('kills_player'):
		var spawner := SpawnsPlayer.first()
		if spawner: spawner.kill_and_respawn_player()
		else: player.queue_free()

func _ready() -> void:
	if not area: area = Resolve.at_by_meta(owner, 'touches_kill_planes', true)
	if not area: push_error('missing area with meta[touches_kill_planes=true] %s' % get_path())
	area.body_entered.connect(on_body_entered)

func _enter_tree() -> void:
	if not player: player = owner
