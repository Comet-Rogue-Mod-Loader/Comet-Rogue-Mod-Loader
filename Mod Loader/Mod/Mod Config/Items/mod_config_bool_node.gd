extends CustomButton

var item: ModConfigItem

func _ready() -> void:
	pressed.connect(   func(): item.set_value(!item.get_value())   )
	item.value_changed.connect(update_message)
	update_message()

func update_message(new_value: Variant = null) -> void:
	var value = new_value if new_value != null else item.get_value()
	message = "%s: %s" % [item.display_name, "On" if value else "Off"]
