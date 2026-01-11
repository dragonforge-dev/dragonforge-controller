extends Control

@onready var controls: Screen = $Controls

func _ready() -> void:
	controls.show()
