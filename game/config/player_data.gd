class_name PlayerData extends Resource

const PLAYER_DATA_FILE := 'user://player_data.tres'

@export var audio_master_volume_linear_0_100 : float = 50.0
@export var audio_bgm_volume_linear_0_100 : float = 50.0
@export var audio_sfx_volume_linear_0_100 : float = 50.0
@export var audio_ui_volume_linear_0_100 : float = 50.0

@export var decay_level: float = 5.0

@export var player_name : String = 'no name'

func save() -> PlayerData:
	ResourceSaver.save(self, PLAYER_DATA_FILE)
	return self

func update_from_audio_server():
	audio_master_volume_linear_0_100 = Audio.get_volume_linear_0_100(AutoloadAudio.AudioBus.Master)
	audio_bgm_volume_linear_0_100 = Audio.get_volume_linear_0_100(AutoloadAudio.AudioBus.BGM)
	audio_sfx_volume_linear_0_100 = Audio.get_volume_linear_0_100(AutoloadAudio.AudioBus.SFX)
	audio_ui_volume_linear_0_100 = Audio.get_volume_linear_0_100(AutoloadAudio.AudioBus.UI)

static func load_from_file_or_create_file() -> PlayerData:
	if ResourceLoader.exists(PLAYER_DATA_FILE):
		var loaded : PlayerData = ResourceLoader.load(PLAYER_DATA_FILE)
		if not loaded.decay_level or loaded.decay_level <= 0:
			loaded.decay_level = 5.0
			loaded.save()
		return loaded
	else:
		PlayerData.new().save()
		return ResourceLoader.load(PLAYER_DATA_FILE)
