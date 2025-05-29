extends Control

@export var config: ModConfig
@onready var content: Control = % "Config Content"
@onready var title: Label = % "Title"
@onready var ok_button: CustomButton = % "Ok Button"

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	ok_button.pressed.connect(
		func():
			visible = false
	)
	get_node("/root/ModLoader").update_config.connect(update_config)

func update_config() -> void:
	for child in content.get_children():
		child.queue_free()
	if config == null: return
	title.text = config.mod.display_name()
	for item in config.items:
		var scene := item.scene()
		if scene == null: continue
		var instance: Node = scene.instantiate()
		if "default_value" in item:
			item.set_value(item.default_value)
		instance.item = item
		content.add_child(instance)

func _on_visibility_changed() -> void:
	if visible:
		update_config()
