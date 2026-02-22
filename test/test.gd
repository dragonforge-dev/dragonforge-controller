extends Control

@onready var controls: Screen = $Controls
@onready var game_play: Screen = $GamePlay

func _ready() -> void:
	controls.show()
	#game_play.show()
