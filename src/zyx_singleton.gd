class_name ZyxPopupWrapper #! singleton-module
extends Singleton.RefCount

const SCRIPT = preload("res://addons/zyx_popup_wrapper/src/zyx_singleton.gd")

const Context2DEditor = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/2d_editor/2d_editor.gd")
const ContextFilesystem = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/filesystem/filesystem.gd")
const ContextFilesystemCreate = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/filesystem_create/filesystem_create.gd")
const ContextSceneTabs = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/scene_tabs/scene_tabs.gd")
const ContextSceneTree = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/scene_tree/scene_tree.gd")
const ContextScriptEditor = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/script_editor/script_editor.gd")
const ContextScriptEditorCode = preload("res://addons/zyx_popup_wrapper/src/editor_plugins/script_editor_code/script_editor_code.gd")

static func get_singleton_name():
	return "ZyxPopupWrapper"

static func register_plugin(plugin:EditorPlugin):
	_register_node(SCRIPT, plugin)


static func get_instance() -> ZyxPopupWrapper:
	return _get_instance(SCRIPT)

static func instance_valid():
	return _instance_valid(SCRIPT)

static func call_on_ready(callable:Callable):
	_call_on_ready(SCRIPT, callable)


func _init(plugin) -> void:
	editor_plugin = plugin
	
	EditorNodeRef.call_on_ready(_add_plugins) # editor node ref must populate popup on beginning, stops premature trigger

func _all_unregistered_callback():
	_remove_plugins()

func _get_ready_bool():
	return plugins_added


var editor_plugin:EditorPlugin
var plugins_added:= false

var context_2d_editor:EditorContextMenuPlugin
var context_filesystem:EditorContextMenuPlugin
var context_filesystem_create:EditorContextMenuPlugin
var context_scene_tabs:EditorContextMenuPlugin
var context_scene_tree:EditorContextMenuPlugin
var context_script_editor:EditorContextMenuPlugin
var context_script_editor_code:EditorContextMenuPlugin


func _add_plugins():
	context_2d_editor = Context2DEditor.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_2D_EDITOR, context_2d_editor)
	context_filesystem = ContextFilesystem.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, context_filesystem)
	context_filesystem_create = ContextFilesystemCreate.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM_CREATE, context_filesystem_create)
	context_scene_tabs = ContextSceneTabs.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCENE_TABS, context_scene_tabs)
	context_scene_tree = ContextSceneTree.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCENE_TREE, context_scene_tree)
	context_script_editor = ContextScriptEditor.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCRIPT_EDITOR, context_script_editor)
	context_script_editor_code = ContextScriptEditorCode.new()
	editor_plugin.add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCRIPT_EDITOR_CODE, context_script_editor_code)
	
	plugins_added = true


func _remove_plugins():
	if not is_instance_valid(editor_plugin):
		printerr("Plugin not valid for ZyxPopupWrapper.")
		return
	
	editor_plugin.remove_context_menu_plugin(context_2d_editor)
	editor_plugin.remove_context_menu_plugin(context_filesystem)
	editor_plugin.remove_context_menu_plugin(context_filesystem_create)
	editor_plugin.remove_context_menu_plugin(context_scene_tabs)
	editor_plugin.remove_context_menu_plugin(context_scene_tree)
	editor_plugin.remove_context_menu_plugin(context_script_editor)
	editor_plugin.remove_context_menu_plugin(context_script_editor_code)


static func wrap_popup(fs_popup, wrapper_params) -> void:
	var new_popup = PopupMenu.new()
	new_popup.submenu_popup_delay = 0
	new_popup.popup_hide.connect(_on_popup_hide.bind(new_popup))
	
	#print(fs_popup, " wrap, singleton")
	PopupWrapper.popup_wrapper(new_popup, fs_popup, wrapper_params)
	PopupWrapper.squash_icons(new_popup)
	PopupWrapper.popup_cleanup(new_popup)
	
	EditorInterface.get_base_control().add_child(new_popup)
	new_popup.position = fs_popup.position
	fs_popup.hide()
	new_popup.show()

static func _on_popup_hide(popup):
	popup.queue_free()


class Enable:
	static func editor_2d(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_2d_editor.enabled = enabled
	static func filesystem(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_filesystem.enabled = enabled
	static func filesystem_create(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_filesystem_create.enabled = enabled
	static func scene_tabs(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_scene_tabs.enabled = enabled
	static func scene_tree(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_scene_tree.enabled = enabled
	static func script_editor(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_script_editor.enabled = enabled
	static func script_editor_code(enabled:bool, printerr:=true):
		if _check_ins(printerr): ZyxPopupWrapper.get_instance().context_script_editor_code.enabled = enabled
	
	static func _check_ins(printerr):
		if ZyxPopupWrapper.instance_valid():
			return true
		else:
			if printerr:
				printerr("ZyxPopupWrapper instance not valid. Check that a plugin has been registered.")
			return false
