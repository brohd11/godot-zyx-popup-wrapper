@tool
extends EditorPlugin

const EditorPluginManager = preload("res://addons/zyx_popup_wrapper/src/utils/remote/editor_plugin_manager.gd")
const EDITOR_PLUGINS_PATH = "res://addons/zyx_popup_wrapper/src/editor_plugins/editor_plugins.json"
var editor_plugin_manager:EditorPluginManager

func _enter_tree() -> void:
	editor_plugin_manager = EditorPluginManager.new(self, EDITOR_PLUGINS_PATH)

func _exit_tree() -> void:
	editor_plugin_manager.remove_plugins()
