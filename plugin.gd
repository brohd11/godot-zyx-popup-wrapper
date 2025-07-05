@tool
extends EditorPlugin

const PLUGINS = {
	"ScriptEditorCodeWrapper": preload("uid://dlttvbpn0s66b"), # script_editor_code_wrapper.gd
}

func _enter_tree() -> void:
	add_plugins(self)

func _exit_tree() -> void:
	remove_plugins(self)


#region Add and Remove Logic

static var context_plugin_instances:Dictionary = {}

static func add_plugins(plugin:EditorPlugin):
	for key in PLUGINS:
		var script:GDScript = PLUGINS.get(key)
		if script.get("Slot"):
			var ins = script.new()
			if ins is EditorContextMenuPlugin:
				plugin.add_context_menu_plugin(ins.Slot, ins)
				context_plugin_instances[key] = ins
			else:
				ins.queue_free()
		else:
			print("Script missing 'Slot' var: %s" % key)

static func remove_plugins(plugin:EditorPlugin):
	for instance_name in context_plugin_instances:
		var instance = context_plugin_instances.get(instance_name)
		if is_instance_valid(instance):
			plugin.remove_context_menu_plugin(instance)

#endregion
