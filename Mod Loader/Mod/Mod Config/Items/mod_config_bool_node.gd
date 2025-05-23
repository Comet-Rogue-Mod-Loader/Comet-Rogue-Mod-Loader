extends ModConfigItemNode

@onready var button: CustomButton = % "Button"

func _ready() -> void:
	button.pressed.connect(
		func():
			item.set_value(!item.get_value())
	)
	item.value_changed.connect(
		func():
			button.message = "%s: %s" % [item.display_name, "On" if item.get_value() else "Off"]
	)
