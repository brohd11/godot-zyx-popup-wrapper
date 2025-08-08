@tool
extends EditorPlugin

const Utils = preload("res://addons/zyx_popup_wrapper/src/utils/zyx_popup_utils.gd")
const UFile = Utils.UFile
const EditorPluginManager = Utils.EditorPluginManager

# deps
const EDITOR_PLUGINS_PATH = "res://addons/zyx_popup_wrapper/src/editor_plugins/zyx_popup_editor_plugins.json" #! dependency
const SCRIPT_EDITOR_CODE = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/script_editor_code/script_editor_code_wrapper.gd")

var editor_plugin_manager:EditorPluginManager


func _enter_tree() -> void:
	editor_plugin_manager = EditorPluginManager.new(self, EDITOR_PLUGINS_PATH)
	
	var gd_scripts = UFile.scan_for_files("res://addons", ["gd"])
	var valid_scripts = []
	for path in gd_scripts:
		var file_name = path.get_file()
		if file_name.find("context_logic") > -1:
			var script = load(path)
			valid_scripts.append(script)
	
	for context_menu_plugin:EditorContextMenuPlugin in editor_plugin_manager._context_plugin_instances.values():
		if context_menu_plugin.has_method("set_popup_scripts"):
			context_menu_plugin.set_popup_scripts(valid_scripts)
	

func _exit_tree() -> void:
	editor_plugin_manager.remove_plugins()



#const PluginLogic = preload("res://addons/zyx_popup_wrapper/src/zyx_popup_wrapper_plugin_logic.gd")
#var plugin_logic:PluginLogic
#
#func _enter_tree() -> void:
	#plugin_logic = PluginLogic.new(self)
	#add_child(plugin_logic)
#
#func _exit_tree() -> void:
	#plugin_logic.queue_free()
