class_name AudioSlider extends HBoxContainer

@export var which_bus : AutoloadAudio.AudioBus

@onready var bus_name_label : Label = %BusNameLabel
@onready var volume_label : Label = %VolumeLabel
@onready var volume_slider : Slider = %VolumeSlider

func on_value_changed(new_value:float):
	Audio.set_volume_linear_0_100(which_bus, new_value, volume_slider, volume_label)
	Audio.play_volume_tick_sound(which_bus)

func _ready() -> void:
	bus_name_label.text = Audio.AudioBus.find_key(which_bus)
	Audio.get_volume_linear_0_100(which_bus, volume_slider, volume_label)
	volume_slider.value_changed.connect(on_value_changed)
