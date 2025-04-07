extends Node

#● MOUSE_BUTTON_NONE = 0
#Enum value which doesn't correspond to any mouse button. This is used to initialize MouseButton properties with a generic state.
#● MOUSE_BUTTON_LEFT = 1
#Primary mouse button, usually assigned to the left button.
#● MOUSE_BUTTON_RIGHT = 2
#Secondary mouse button, usually assigned to the right button.
#● MOUSE_BUTTON_MIDDLE = 3
#Middle mouse button.
#● MOUSE_BUTTON_WHEEL_UP = 4
#Mouse wheel scrolling up.
#● MOUSE_BUTTON_WHEEL_DOWN = 5
#Mouse wheel scrolling down.
#● MOUSE_BUTTON_WHEEL_LEFT = 6
#Mouse wheel left button (only present on some mice).
#● MOUSE_BUTTON_WHEEL_RIGHT = 7
#Mouse wheel right button (only present on some mice).
#● MOUSE_BUTTON_XBUTTON1 = 8
#Extra mouse button 1. This is sometimes present, usually to the sides of the mouse.
#● MOUSE_BUTTON_XBUTTON2 = 9
#Extra mouse button 2. This is sometimes present, usually to the sides of the mouse.
@export var mouse_button_images: Array[Texture2D]


## Returns the Texture2D representation of the mouse button event passed.
## Returns null if the InputEvent is not a MouseButtonEvent.
func get_mouse_icon(action: InputEvent) -> Texture2D:
	if action is InputEventMouseButton:
		return mouse_button_images[action.button_index]
	return
