extends EditorContextMenuPlugin

var enabled:bool = true

func _popup_menu(paths: PackedStringArray) -> void:
	await Engine.get_main_loop().root.get_tree().process_frame
	if not enabled:
		return
	
	var fs_popup = EditorNodeRef.get_node_ref(EditorNodeRef.Nodes.FILESYSTEM_POPUP) as PopupMenu
	var fs_bottom_popup = EditorNodeRef.get_node_ref(EditorNodeRef.Nodes.FILESYSTEM_BOTTOM_POPUP) as PopupMenu
	
	var actual_popup = fs_popup
	if not fs_popup.visible:
		actual_popup = fs_bottom_popup
	
	var wrapper_params = PopupWrapper.WrapperParams.new()
	wrapper_params.show_shortcuts = true
	
	ZyxPopupWrapper.wrap_popup(actual_popup, wrapper_params)
