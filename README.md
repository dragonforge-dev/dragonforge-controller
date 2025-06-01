# Dragonforge Controller
A controller autoload singleton to handle game input from gamepads (controllers) and keyboard/mouse.
# Version 0.10.1
For use with **Godot 4.4.1-stable** and later.
# Installation Instructions
1. Copy the **dragonforge_controller** folder from the **addons** folder into your project's **addons** folder.
2. Ignore the following errors (they are appearing because the component is not yet enabled):
  * ERROR: res://addons/dragonforge_controller/controller.gd:54 - Parse Error: Identifier "Keyboard" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:56 - Parse Error: Identifier "Mouse" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:59 - Parse Error: Identifier "Gamepad" not declared in the current scope.
  * ERROR: modules/gdscript/gdscript.cpp:3022 - Failed to load script "res://addons/dragonforge_controller/controller.gd" with error "Parse error".
3. In your project go to **Project -> Project Settings...**
4. Select the **plugins** tab.
5. Check the **On checkbox** under **Enabled** for **Dragonforge Controller**
6. Press the **Close** button.

Four autoloads will be added. If you would like to ensure the errors are gone, go to **Project -> Reload Project**. When the project reloads, the previous errors should no longer appear. (We cannot guarantee your own errors will not still appear.)
#Usage
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

#To Do
- Add in detection of Steam Deck and add button icons
