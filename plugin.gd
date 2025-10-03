@tool
extends EditorPlugin

var zyx

func _enter_tree() -> void:
	zyx = ZyxPopupWrapper.register_plugin(self)
	

func _exit_tree() -> void:
	if is_instance_valid(zyx):
		zyx.unregister_node(self)
