extends TextureButton


@export var message: String
@export var disabled_message: String
@export var press_sound: AudioStream
@export var release_sound: AudioStream
@export var focus_sound: AudioStream
@export var unfocus_sound: AudioStream

var has_mouse: bool = false

@onready var label: CorrectSpacingLabel = $HBoxContainer2/Label
@onready var custom_audio_player: CustomAudioPlayer = $CustomAudioPlayer


func _ready() -> void :
	label.label_settings = label.label_settings.duplicate()
 

func _process(delta: float) -> void :
	if has_focus():
		label.label_settings.outline_color = Color("065AB5")
	else: label.label_settings.outline_color = Color("000000")

	if disabled_message and disabled:
		label.text = disabled_message
	else:
		label.text = message


func _on_mouse_entered() -> void :
	grab_focus()
	has_mouse = true


func _on_mouse_exited() -> void :
	has_mouse = false


func _on_button_down() -> void :
	if press_sound:
		custom_audio_player.play_sound(press_sound.resource_path, 0, 1, 0.1, "SFX", true)


func _on_button_up() -> void :
	if release_sound:
		custom_audio_player.play_sound(release_sound.resource_path, 0, 1, 0.1, "SFX", true)


func _on_focus_entered() -> void :
	custom_audio_player.play_sound(focus_sound.resource_path, 0, 1, 0.05, "SFX", true)


func _on_focus_exited() -> void :
	custom_audio_player.play_sound(unfocus_sound.resource_path, 0, 1, 0.1, "SFX", true)
	for button in get_tree().get_nodes_in_group("custom button"):
		button.button_pressed = false
