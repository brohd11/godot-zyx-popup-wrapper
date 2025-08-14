#extends Node
#
#### DEPRECATED
#
#const Utils = preload("res://addons/zyx_popup_wrapper/src/utils/zyx_popup_utils.gd")
#const UFile = Utils.UFile
#const EditorPluginManager = Utils.EditorPluginManager
#const PopupHelper = Utils.PopupHelper
## deps
#const EDITOR_PLUGINS_PATH = "res://addons/zyx_popup_wrapper/src/editor_plugins/zyx_popup_editor_plugins.json" #
#const SCRIPT_EDITOR_CODE = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/script_editor_code/script_editor_code_wrapper.gd")
#
#var editor_plugin_manager:EditorPluginManager
#
#var plugin:EditorPlugin
#
#func _init(_plugin:EditorPlugin) -> void:
	#plugin = _plugin
#
#func _enter_tree() -> void:
	#editor_plugin_manager = EditorPluginManager.new(plugin, EDITOR_PLUGINS_PATH)
	#
	#var gd_scripts = UFile.scan_for_files("res://addons", ["gd"])
	#var valid_scripts = []
	#for path in gd_scripts:
		#var file_name = path.get_file()
		#if file_name.find("context_logic") > -1:
			#var script = load(path)
			#valid_scripts.append(script)
	#
	#for context_menu_plugin:EditorContextMenuPlugin in editor_plugin_manager._context_plugin_instances.values():
		#if context_menu_plugin.has_method("set_popup_scripts"):
			#context_menu_plugin.set_popup_scripts(valid_scripts)
	#
#
#func _exit_tree() -> void:
	#editor_plugin_manager.remove_plugins()
#
#
#static func get_non_plugin_script_data(scripts, script_editor):
	#return _get_non_plugin_script_data(scripts, script_editor)
#
#static func _get_non_plugin_script_data(scripts, script_editor):
	#var script_data = {}
	#for script in scripts:
		#var callable = script.get_callable()
		#var items:Dictionary = script.get_popup_data(script_editor)
		#if callable != null and items != null:
			#for key in items:
				#var data = items.get(key)
				#data[PopupHelper.ParamKeys.CALLABLE_KEY] = callable
				#script_data[key] = data
	#return script_data
