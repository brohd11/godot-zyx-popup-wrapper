extends EditorContextMenuPlugin

const SLOT = ContextMenuSlot.CONTEXT_SLOT_SCRIPT_EDITOR_CODE

const Utils = preload("res://addons/zyx_popup_wrapper/src/utils/zyx_popup_utils.gd")
const PopupWrapper = Utils.PopupWrapper
const PopupHelper = Utils.PopupHelper
const ScriptEd = Utils.ScriptEd

func _popup_menu(paths: PackedStringArray) -> void:
	var script_editor:CodeEdit = Engine.get_main_loop().root.get_node(paths[0]);
	
	await script_editor.get_tree().process_frame
	
	var new_popup = PopupMenu.new()
	new_popup.submenu_popup_delay = 0
	new_popup.popup_hide.connect(_on_popup_hide.bind(new_popup))
	
	var fs_popup = ScriptEd.get_popup()
	
	var wrapper_params = PopupWrapper.WrapperParams.new()
	wrapper_params.show_shortcuts = true
	
	PopupWrapper.popup_wrapper(new_popup, fs_popup, wrapper_params)
	
	PopupWrapper.squash_icons(new_popup)
	PopupWrapper.popup_cleanup(new_popup)
	
	#await script_editor.get_tree().process_frame
	EditorInterface.get_base_control().add_child(new_popup)
	new_popup.position = fs_popup.position
	
	fs_popup.hide()
	new_popup.show()
	#new_popup.popup()


func _on_popup_hide(popup):
	popup.queue_free()
