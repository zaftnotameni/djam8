class_name FixesProblems extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('player_interact'):
		if HighlightsInteractions.current_highlight:
			if HighlightsInteractions.current_highlight.has_meta('has_problems'):
				HighlightsInteractions.current_highlight.remove_meta('has_problems')
				Audio.play_named_sfx(NamedAudio.SFX.SFX_FixThing, false)
				print(HighlightsInteractions.current_highlight)
				HighlightsInteractions.current_highlight.get_node("FixParticle").emitting = true
				for sprite in get_tree().get_nodes_in_group('tutorial_sprites'):
					sprite.modulate.a = 0.0
