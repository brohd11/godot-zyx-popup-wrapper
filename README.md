# ZyxPopupWrapper

This is a thin wrapper of [popup-wrapper](https://github.com/brohd11/godot-popup-wrapper.git), a library that recreates the editor's
popups, allowing to re-order where items appear.

This repo serves as a plugin to instance the wrapper singleton in the case there is no plugin using it.

## Install

This plugin uses external dependencies packaged with [GDPackage](https://github.com/brohd11/godot-gdpackage.git),
download the latest package from releases, it includes the required dependencies.
The "require" key in plugin.cfg|package.cfg lists all dependency repos.

You can also use [gdaddon](https://github.com/brohd11/gdaddon) to manage the installation.
It is a TUI package/repo manager that can install and update addons for you.

In your project:
```
gdaddon install brohd11/godot-zyx-popup-wrapper/release
```
