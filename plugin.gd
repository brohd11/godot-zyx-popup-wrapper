@tool
extends EditorPlugin

func _enter_tree() -> void:
	ZyxPopupWrapperSingleton.register_node(self)

func _exit_tree() -> void:
	ZyxPopupWrapperSingleton.unregister_node(self)
