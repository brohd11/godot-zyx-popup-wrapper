@tool
extends EditorPlugin

const Utils = preload("res://addons/zyx_popup_wrapper/src/utils/zyx_popup_utils.gd")
const UFile = Utils.UFile
const EditorPluginManager = Utils.EditorPluginManager

const CONTEXT_PLUGINS = [
	"res://addons/zyx_popup_wrapper/src/editor_plugins/script_editor_code/script_editor_code_wrapper.gd" #! dependency
]

var editor_plugin_manager:EditorPluginManager

func _enter_tree() -> void:
	editor_plugin_manager = EditorPluginManager.new(self)
	editor_plugin_manager.context_menu_plugin_paths = CONTEXT_PLUGINS
	editor_plugin_manager.add_plugins()
	

func _exit_tree() -> void:
	editor_plugin_manager.remove_plugins()
