@tool
extends EditorPlugin

func _enter_tree() -> void:
	PopupWrapperSingleton.register_node(self)

func _exit_tree() -> void:
	PopupWrapperSingleton.unregister_node(self)
