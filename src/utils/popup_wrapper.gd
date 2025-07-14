extends RefCounted

static func popup_wrapper(new_popup:PopupMenu, popup_to_copy:PopupMenu, fs_callable):
	_copy_popup(new_popup, popup_to_copy, fs_callable)
	new_popup.id_pressed.connect(fs_callable.bind(new_popup, popup_to_copy))
	return new_popup

static func _copy_popup(new_popup:PopupMenu, popup_to_copy:PopupMenu, callable):
	var base_index = new_popup.item_count
	for i in range(popup_to_copy.item_count):
		var is_sep = popup_to_copy.is_item_separator(i)
		if is_sep:
			new_popup.add_separator()
			continue
		var id = popup_to_copy.get_item_id(i)
		var text = popup_to_copy.get_item_text(i)
		var submenu = popup_to_copy.get_item_submenu_node(i)
		var icon = popup_to_copy.get_item_icon(i)
		if is_instance_valid(submenu):
			var new_submenu = PopupMenu.new()
			_copy_popup(new_submenu, submenu, callable)
			new_submenu.id_pressed.connect(callable.bind(new_submenu, submenu))
			new_popup.add_submenu_node_item(text, new_submenu)
		else:
			var short_cut = popup_to_copy.get_item_shortcut(i)
			new_popup.add_item(text, id)
			new_popup.set_item_shortcut(base_index + i, short_cut)
		if icon:
			new_popup.set_item_icon(base_index + i, icon)

static func squash_icons(popup:PopupMenu):
	var popup_has_texture = false
	for i in range(popup.item_count):
		if popup.get_item_icon(i) != null:
			popup_has_texture = true
			break
	if popup_has_texture:
		for i in range(popup.item_count):
			if popup.get_item_icon(i) != null:
				continue
			popup.set_item_indent(i, -2)
