@tool
class_name AutoloadAudio extends Node

const AUDIO_FOLDER := 'res://assets/audio'
const AUDIO_CONSTS := 'res://game/audio/generated_named_audio.gd'

enum AudioBus { Master = 0, BGM = 1, SFX = 2, UI = 3 }

signal sig_volume_changed(which_bus:AudioBus, volume_linear_0_100:float)

var audio_to_ignore = {}

func play_named_ui(audio_id_from_enum:NamedAudio.UI): play_named(get_name_ui(audio_id_from_enum))
func play_named_bgm(audio_id_from_enum:NamedAudio.BGM): play_named(get_name_bgm(audio_id_from_enum))
func play_named_sfx(audio_id_from_enum:NamedAudio.SFX): play_named(get_name_sfx(audio_id_from_enum))
func play_named_master(audio_id_from_enum:NamedAudio.Master): play_named(get_name_master(audio_id_from_enum))

func get_name_ui(audio_id_from_enum:NamedAudio.UI) -> String: return NamedAudio.UI.find_key(audio_id_from_enum)
func get_name_bgm(audio_id_from_enum:NamedAudio.BGM) -> String: return NamedAudio.BGM.find_key(audio_id_from_enum)
func get_name_sfx(audio_id_from_enum:NamedAudio.SFX) -> String: return NamedAudio.SFX.find_key(audio_id_from_enum)
func get_name_master(audio_id_from_enum:NamedAudio.Master) -> String: return NamedAudio.Master.find_key(audio_id_from_enum)

func get_named(audio_name:String) -> AudioStreamPlayer: return get_node(audio_name)
func play_named(audio_name:String):
	if audio_to_ignore.has(audio_name) and audio_to_ignore[audio_name] > 0:
		audio_to_ignore[audio_name] = audio_to_ignore.get_or_add(audio_name, 0) - 1
	else:
		get_named(audio_name).play()

func ignore_next(audio_name:String, how_many:int=1):
	audio_to_ignore[audio_name] = audio_to_ignore.get_or_add(audio_name, 0) + how_many


func update_ui(volume_linear_0_100:float, slider:Slider=null, label:Label=null):
	if slider: slider.value = volume_linear_0_100
	if label: label.text = str(roundi(volume_linear_0_100))

func set_volume_linear_0_100(which_bus:AudioBus, volume_linear_0_100:float, slider:Slider=null, label:Label=null, skip_update_from_audio_server:=false):
	AudioServer.set_bus_volume_db(which_bus, linear_to_db(volume_linear_0_100 / 100.0))
	update_ui(volume_linear_0_100, slider, label)
	if not skip_update_from_audio_server:
		Config.player_data.update_from_audio_server()
		Config.player_data.save()
	sig_volume_changed.emit(which_bus, volume_linear_0_100)

func get_volume_linear_0_100(which_bus:AudioBus, slider:Slider=null, label:Label=null) -> float:
	var volume_db := AudioServer.get_bus_volume_db(which_bus)
	var volume_linear_0_100 : float = db_to_linear(volume_db) * 100.0
	update_ui(volume_linear_0_100, slider, label)
	return volume_linear_0_100

func play_volume_tick_sound(which_bus:AudioBus):
	match which_bus:
		AudioBus.Master: play_named_master(NamedAudio.Master.Master_VolumeTick)
		AudioBus.BGM: play_named_bgm(NamedAudio.BGM.BGM_VolumeTick)
		AudioBus.SFX: play_named_sfx(NamedAudio.SFX.SFX_VolumeTick)
		AudioBus.UI: play_named_ui(NamedAudio.UI.UI_VolumeTick)

func read_volume_from_config():
	if Engine.is_editor_hint(): return
	set_volume_linear_0_100(AudioBus.Master, Config.player_data.audio_master_volume_linear_0_100, null, null, true)
	set_volume_linear_0_100(AudioBus.BGM, Config.player_data.audio_bgm_volume_linear_0_100, null, null, true)
	set_volume_linear_0_100(AudioBus.SFX, Config.player_data.audio_sfx_volume_linear_0_100, null, null, true)
	set_volume_linear_0_100(AudioBus.UI, Config.player_data.audio_ui_volume_linear_0_100, null, null, true)

func _enter_tree() -> void:
	read_volume_from_config()

func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_PRE_SAVE:
		if Engine.is_editor_hint():
			if get_tree().edited_scene_root == self:
				setup_local_files()

func setup_local_files():
	for child in get_children():
		if child.has_meta('created_via_automation'):
			child.queue_free()
			await child.tree_exited
	var ui := await load_audio_streams_for('UI')
	var bgm := await load_audio_streams_for('BGM')
	var sfx := await load_audio_streams_for('SFX')
	var master := await load_audio_streams_for('Master')
	generate_named_enum({ 'UI': ui, 'BGM': bgm, 'SFX': sfx, 'Master': master })

func generate_named_enum(data:Dictionary):
	var fa := FileAccess.open(AUDIO_CONSTS, FileAccess.WRITE)
	var enums := ''
	for key in data.keys():
		enums += '\nenum %s {\n\t%s\n}\n' % [key, ',\n\t'.join(data[key])]
	fa.store_string('class_name NamedAudio extends RefCounted\n%s' % enums)
	fa.close()

func load_audio_streams_for(audio_bus_name:String) -> Array:
	var res := []
	if audio_bus_name != 'Master' and not AudioServer.get_bus_index(audio_bus_name):
		push_error('no bus named: ' + audio_bus_name)

	var dir := DirAccess.open('%s/%s' % [AUDIO_FOLDER, audio_bus_name])
	dir.list_dir_begin()
	while true:
		var file_or_dir_name := dir.get_next()
		if not file_or_dir_name or file_or_dir_name.is_empty(): break
		if not ['.ogg', '.wav', '.mp3'].any(file_or_dir_name.ends_with): continue

		var full_path := '%s/%s/%s' % [AUDIO_FOLDER, audio_bus_name, file_or_dir_name]
		var audio_stream : AudioStream = load(full_path)
		printt('processing:', full_path)

		var audio_stream_player := AudioStreamPlayer.new()
		audio_stream_player.name = audio_bus_name + '_' + file_or_dir_name.split('.')[0].to_pascal_case()
		audio_stream_player.stream = audio_stream
		if audio_bus_name != 'Master': audio_stream_player.bus = audio_bus_name

		audio_stream_player.set_meta('created_via_automation', true)
		add_child.call_deferred(audio_stream_player)
		await audio_stream_player.ready
		audio_stream_player.owner = self

		res.push_back(audio_stream_player.name)
	return res
