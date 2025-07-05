extends EditorContextMenuPlugin

const Slot = ContextMenuSlot.CONTEXT_SLOT_SCRIPT_EDITOR_CODE
const Utils = preload("res://addons/zyx_popup_wrapper/plugin/utils/utils.gd")

const PopupWrapper = Utils.PopupWrapper

const PopupHelper = Utils.PopupHelper
const ScriptEd = Utils.ScriptEd

const PRE_POPUP_ARRAY = [
	"res://addons/syntax_tags/plugin/syntax_tag_context_logic.gd",
	"res://addons/modular_browser/lib_editor/editor_plugins/context_menu/script_editor/path_uid/path_uid_logic.gd",
]

var pre_popup_scripts = []

func _init() -> void:
	for path in PRE_POPUP_ARRAY:
		if not FileAccess.file_exists(path):
			continue
		var script = load(path)
		if not script is Script:
			push_error("File is not script: %s" % path)
			continue
		pre_popup_scripts.append(script)

func _popup_menu(paths: PackedStringArray) -> void:
	print("YUP")
	var script_editor:CodeEdit = Engine.get_main_loop().root.get_node(paths[0]);
	#await script_editor.get_tree().process_frame
	var script_data = {}
	for script in pre_popup_scripts:
		var callable = script.get_callable()
		var items:Dictionary = script.get_popup_data(script_editor)
		if callable != null and items != null:
			for key in items:
				var data = items.get(key)
				data[PopupHelper.ParamKeys.CALLABLE_KEY] = callable
				script_data[key] = data
	
	var new_popup = PopupMenu.new()
	new_popup.submenu_popup_delay = 0
	new_popup.popup_hide.connect(_on_popup_hide.bind(new_popup))
	var base_id = 5000
	PopupHelper.parse_dict_static(script_data, new_popup, _custom_item_pressed, null, base_id, [script_editor, script_data])
	var fs_popup = ScriptEd.get_popup()
	PopupWrapper.popup_wrapper(new_popup, fs_popup, wrapper_pressed)
	PopupWrapper.squash_icons(new_popup)
	
	await script_editor.get_tree().process_frame
	
	
	EditorInterface.get_base_control().add_child(new_popup)
	new_popup.position = fs_popup.position
	
	fs_popup.hide()
	new_popup.show()

func _on_popup_hide(popup):
	popup.queue_free()

func _custom_item_pressed(id, wrapper_popup, script_editor, script_data):
	if id < 5000:
		return
	var menu_path = PopupHelper.parse_menu_path(id, wrapper_popup)
	var target_script_data = script_data.get(menu_path)
	var callable = target_script_data.get(PopupHelper.ParamKeys.CALLABLE_KEY)
	if callable:
		callable.call(id, wrapper_popup, script_editor)

func wrapper_pressed(id, wrapper_popup, fs_popup):
	if id >= 5000:
		return
	fs_popup.id_pressed.emit(id)
