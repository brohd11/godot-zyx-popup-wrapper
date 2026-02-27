extends EditorContextMenuPlugin

var enabled:bool = true

func _popup_menu(paths: PackedStringArray) -> void:
	await Engine.get_main_loop().root.get_tree().process_frame
	if not enabled:
		return
	
	var fs_popup = EditorNodeRef.get_registered(EditorNodeRef.Nodes.SCENE_TREE_POPUP)
	
	var wrapper_params = PopupWrapper.WrapperParams.new()
	wrapper_params.show_shortcuts = true
	
	ZyxPopupWrapperSingleton.wrap_popup(fs_popup, wrapper_params)
