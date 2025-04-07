# Dragonforge Controller
A controller autoload singleton to handle game input from gamepads (controllers) and keyboard/mouse.
# Version 4.4.8
For use with **Godot 4.4.stable** and later.
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

If you would like to ensure the errors are gone, go to **Project -> Reload Project**. When the project reloads, the previous errors should no longer appear. (We cannot guarantee your own errors will not still appear.)
