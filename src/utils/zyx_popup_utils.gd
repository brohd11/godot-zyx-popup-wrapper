#! remote res://addons/zyx_popup_wrapper/src/utils/remote/

const EditorPluginManager = preload("res://addons/addon_lib/brohd/editor_plugin_manager/editor_plugin_manager.gd")
const PopupWrapper = preload("res://addons/addon_lib/brohd/popup_wrapper/popup_wrapper.gd")
const PopupHelper = preload("res://addons/addon_lib/brohd/alib_runtime/popup_menu/popup_menu_path_helper.gd")
const ScriptEd = preload("res://addons/addon_lib/brohd/alib_editor/utils/src/editor_nodes/script_editor.gd")
const UFile = preload("res://addons/addon_lib/brohd/alib_runtime/utils/src/u_file.gd")

static func sort_popup_scripts(wrapper_plugin, scripts):
	var pre_dict = {}
	var post_dict = {}
	for script in scripts:
		if "Slot" in script:
			if script.Slot != wrapper_plugin.Slot:
				continue
			var priority = 1000
			if "PopupPriority" in script:
				priority = script.PopupPriority
			
			if "PostPopup" in script:
				if script.PostPopup and "post_popup_scripts" in wrapper_plugin:
					var post_dict_keys = post_dict.keys()
					while priority in post_dict_keys:
						priority += 1
					
					post_dict[priority] = script
					continue
			
			var pre_dict_keys = pre_dict.keys()
			while priority in pre_dict_keys:
				priority += 1
			pre_dict[priority] = script
	
	var pre_dict_keys = pre_dict.keys()
	pre_dict_keys.sort()
	for key in pre_dict_keys:
		var script = pre_dict.get(key)
		wrapper_plugin.pre_popup_scripts.append(script)
	
	var post_dict_keys = post_dict.keys()
	post_dict_keys.sort()
	for key in post_dict_keys:
		var script = post_dict.get(key)
		wrapper_plugin.post_popup_scripts.append(script)
