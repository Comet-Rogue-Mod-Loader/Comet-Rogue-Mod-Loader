extends Control

@export var id: String
@export var can_toggle: bool = true

@onready var icon: TextureRect = % "Icon"
@onready var display_name: RichTextLabel = % "DisplayName"
@onready var version: Label = % "Version"
@onready var description: RichTextLabel = % "Description"
@onready var credit: RichTextLabel = % "Credit"
@onready var credit_control: Control = % "CreditControl"

@onready var toggle_button: CustomButton = % "Toggle"

func _ready() -> void:
	update()
	
	toggle_button.pressed.connect(_on_toggle_button_pressed)
	visibility_changed.connect(_on_visibility_changed)
	
	credit_control.mouse_entered.connect(func() -> void: credit.visible = true)
	credit_control.mouse_exited.connect(func() -> void: credit.visible = false)

func _process(_delta: float) -> void:
	credit.global_position = get_global_mouse_position()

func _on_visibility_changed() -> void:
	if visible: update()
	credit.visible = false

func update() -> void:
	var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod(id)
	if mod == null:
		display_name.text = id
		return
	icon.texture = mod.icon()
	display_name.text = mod.display_name()
	version.text = mod.version()
	description.text = mod.description()
	credit.text = '[wave]Credit: %s[/wave]' % mod.credit()
	
	toggle_button.disabled = !can_toggle
	
	toggle_button.message = "Enabled" if mod.enabled else "Disabled"
	toggle_button.modulate = Color(0.7, 1.0, 0.7) if mod.enabled else Color(1.0, 0.7, 0.7)
	

func _on_toggle_button_pressed() -> void:
	var mod: Mod = get_node("/root/ModLoader").mod_manager.get_mod(id)
	mod.enabled = !mod.enabled
	
	toggle_button.message = "Enabled" if mod.enabled else "Disabled"
	toggle_button.modulate = Color(0.7, 1.0, 0.7) if mod.enabled else Color(1.0, 0.7, 0.7)
