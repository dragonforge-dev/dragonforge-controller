[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.6.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
[![License](https://img.shields.io/github/license/dragonforge-dev/dragonforge-controller?logo=mit)](https://github.com/dragonforge-dev/dragonforge-controller/blob/main/LICENSE)
[![GitHub release badge](https://badgen.net/github/release/dragonforge-dev/dragonforge-controller/stable)](https://github.com/dragonforge-dev/dragonforge-controller/releases/latest)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-controller)](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-controller)

# Dragonforge Controller <img src="/addons/dragonforge_controller/assets/textures/icons/device-controller.svg" width="32" alt="Controller Project Icon"/>
A controller autoload singleton to handle game input from gamepads (controllers) and keyboard/mouse.
# Version 0.14.1
For use with **Godot 4.6.stable** and later.
## Dependencies
The following dependencies are included in the addons folder and are required for the template to function.
- [Dragonforge User Interface 0.2.1](https://github.com/dragonforge-dev/dragonforge-user-interface)
# Installation Instructions
1. Copy the `dragonforge_controller` folder from the `addons` folder into your project's `addons` folder.
2. Ignore the following errors (they are appearing because the component is not yet enabled):
  * ERROR: res://addons/dragonforge_controller/controller.gd:54 - Parse Error: Identifier "Keyboard" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:56 - Parse Error: Identifier "Mouse" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:59 - Parse Error: Identifier "Gamepad" not declared in the current scope.
  * ERROR: modules/gdscript/gdscript.cpp:3022 - Failed to load script "res://addons/dragonforge_controller/controller.gd" with error "Parse error".
3. If it does not exist already, copy the `dragonforge_user_interface` folder from the `addons` folder into your project's `addons` folder.
4. In your project go to **Project -> Project Settings...**
5. Select the **plugins** tab.
6. Check the **On checkbox** under **Enabled** for **Dragonforge Controller**
7. Check the **On checkbox** under **Enabled** for **Dragonforge User Interface**.
8. Press the **Close** button.

Four autoloads will be added. If you would like to ensure the errors are gone, go to **Project -> Reload Project**. When the project reloads, the previous errors should no longer appear. (We cannot guarantee your own errors will not still appear.)

# Usage Instructions
The primary purpose of this plugin is to track inputs, store icons for all actions, make it easy to pull up the correct icon for any action, and to allow players to customize and save keybindings. For implementation details, see the Dragonforge Game Template.
Supports:
- XBox Controllers
- Playstation Controllers
- Nintendo Controllers
- Keyboard (English Only)
- Mouse

## Get Last Input Type and Getting an Action Icon
The function `Controller.get_last_input_type()` can be used to get whether the last input recevied from the player was of type `Controller.LastInput.KEYBOARD_AND_MOUSE` or `Controller.LastInput.GAMEPAD`. This can be used in gameplay where needed. However the real benefit is in retrieving UI icons.

Let's say you have an "interact" action defined. When you call `Controller.get_action_icon("interact")` you will receive a **Textrure2D** you can assign to a TextureRect and the UI will tell the player what the interact button is based on whther they last moved the mouse or gamepad joystick, and will returtn it based on the device they have plugged in. (They'll get an Xbox button for example if they are using an XBox controller.)

## Controller.look
The `Controller.look` value stores the information needed to implement a camera 3D look either for an FPS or a 3D free look camera. **Controller** handles making sure that the input is based on whichever controls the player is currently using, and makes both smoothly function. This allows a developer to support both without having to do any additional work. For implementation details, check out **Dragonforge Character** which implements this through the **CameraMount** class.

# Class Descriptions
## Controller (Autoload) <img src="/addons/dragonforge_controller/assets/textures/icons/generic_joystick_red_right.svg" width="32" alt="Controller Icon"/>
This is the interface for the other classes. Typically you should not need to reference them directly.
### Signals
- `restore_default_keybindings` Signal that there is a request to load the default keybindings shipped with the game. (I.E. what was set in the Godot Editor.) Calls `Controller._on_restore_default_keybindings()` which will reset all keybindings to default.
- `show_action_display(action_name: String, action_text: String)` Signal to tell the action display to show up and what to show. (For example, the hint to press a key to skip a dialog, tutorial info, or the info on how to enter a building.) Action display must be implemented separately. (For an example see [dragonforge-game-template](https://github.com/dragonforge-dev/dragonforge-game-template).)
- `hide_action_display` Signal to stop showing the action display.
- `input_method_changed(last_input_type: LastInput)` Allows anything listening (like UI) to know when the input method being used changed for something new. Primarily for changing what interaction hints and control icons are shown on screen.

### Enums
- `LastInput` Enumerates the kinds of inputs that are tracked. Currently those are:

```
enum LastInput {
	KEYBOARD_AND_MOUSE,
	GAMEPAD
}
```

### Export Variables
- `enable_3d_look = false` When true, 3D look is on for the game. The right stick will look, as well as the mouse. In addition the mouse will be captured when the game is playing and freed when the game is paused. Defaults to `false` (off).

### Public Member Variables
- `look: Vector2` Stores the amount of movement in the x/y direction that the player is trying to look in a 3D game. The export variable enable_3d_look must be set to true for this to have any value. (See dragonforge-character-3d for usage example.)

### Public Functions
- `get_last_input_type() -> LastInput` Returns the last input type used by the player.
- `get_action_icon(action_name: String, input_type: LastInput = _last_input_type) -> Texture2D` Returns the correct Texture2D representation of the action passed based on the last input type used by the player - which can be specified. (Useful when the type changes and you want to update the UI immediately - resovles race conditions.)
- `rebind_action(action: String, event: InputEvent) -> void` Sets the passed event for the given action in the InputMap and saves it to disk for loading the next time the game is loaded.
- `event_to_string(event: InputEvent) -> String` Returns a string representation of the passed InputEvent. Returns a string of "Unknown" if the InputEvent was not listed here.


## Keyboard (Autoload) <img src="/addons/dragonforge_controller/assets/textures/icons/keyboard.svg" width="32" alt="Keyboard Icon"/>

### Public Functions
- `get_key_icon(event: InputEventKey) -> Texture2D` Returns the Texture2D representation of the keyboard key event passed

## Gamepad (Autoload)

### Enums
- `Type` Enumerates the types of controllers that we have button images for. Currently those are:

```
enum Type {
	XBox,
	Playstation,
	Nintendo,
	Unknown
}
```

### Export Variables
- `horizontal_look_sensitivity: float = 0.075` Right stick horizontal look sensitivity modifier for 3D camera controls.
- `vertical_look_sensitivity: float = 0.0375` Right stick horizontal look sensitivity modifier for 3D camera controls.

#### Images
All of these are exported so that they can be replaced by custom images if you so choose. More details are in the comments. (Including the lists above mentioned.)
- `xbox_button_images: Array[Texture2D]` Stores XBox button icons based on the list above.
- `playstation_button_images: Array[Texture2D]` Stores Playstation button icons based on the list above.
- `nintendo_button_images: Array[Texture2D]` Stores Nintendo button icons based on the list above.
- `xbox_positive_joystick_images: Array[Texture2D]` Stores XBox positive joystick and trigger icons based on the list above.
- `playstation_positive_joystick_images: Array[Texture2D]` Stores Playstation positive joystick and trigger icons based on the list above.
- `nintendo_positive_joystick_images: Array[Texture2D]` Stores Nintendo positive joystick and trigger icons based on the list above.
- `xbox_negative_joystick_images: Array[Texture2D]` Stores XBox negative joystick icons based on the list above.
- `playstation_negative_joystick_images: Array[Texture2D]` Stores Playstation negative joystick icons based on the list above.
- `nintendo_negative_joystick_images: Array[Texture2D]` Stores Nintendo negative joystick icons based on the list above.

### Public Functions
- `get_gamepad_type(device: int = 0) -> Type` Gets the type of gamepad being used by the player. Assumes we want the first device unless another device number is passed.
- `get_gamepad_name(device: int = 0) -> String`  Returns a human-readable name for a gamepad based on the type detected.
- `get_gamepad_icon(action: InputEvent, device: int = 0) -> Texture2D`  Returns the Texture2D representation of the gamepad event passed, based on the type of gamepad the player is using. Returns null if the  InputEvent passed is not a Joypad event.


## Mouse (Autoload) <img src="/addons/dragonforge_controller/assets/textures/icons/mouse.svg" width="32" alt="Mouse Icon"/>
### Export Variables
- `sensitivity: float = 0.0075` Look sensitivity modifier for 3D camera controls
- `mouse_button_images: Array[Texture2D]` Stores mouse button icons based on the list above.

### Public Functions
- `get_mouse_icon(action: InputEvent) -> Texture2D` Returns the Texture2D representation of the mouse button event passed. Returns null if the InputEvent is not a MouseButtonEvent.

# Localization
This project's UI has been created to work with localization. You can easily use localization by using the [Dragonforge Localization](https://github.com/dragonforge-dev/dragonforge-localization) plugin. The following labels exist and should be given translations:

- ACTION
- KEYBOARD
- MOUSE
- BACK
- RESET

There are also default actions that show up in the Key Map screen. They are:
- MOVE_UP
- MOVE_DOWN
- MOVE_LEFT
- MOVE_RIGHT
- INTERACT

These can be changed, rmeoved and added to inside the **Controller** Autoload scene located at `res://addons/dragonforge_controller/controller.tscn`.
