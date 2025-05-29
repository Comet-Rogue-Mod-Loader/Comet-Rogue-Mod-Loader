extends CustomButton

var item: ModConfigButtonItem

func _ready() -> void:
	message = item.display_name
	pressed.connect(item.function)
