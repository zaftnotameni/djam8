@tool
### prototyping tool, creates solid bodies matching line segments, obsolete once we have a proper ship
class_name LineToCollider extends Node

var line : Line2D

func on_pre_save():
	if not ToolUtil.is_owned_by_edited_scene(self): return
	await ToolUtil.remove_all_children_created_via_tool_from(line)
	var bod := StaticBody2D.new()
	await ToolUtil.tool_add_child(line, bod)
	for idx in line.points.size() - 1:
		var a := line.points[idx]
		var b := line.points[idx + 1]
		var col := CollisionShape2D.new()
		var seg := SegmentShape2D.new()
		seg.a = a
		seg.b = b
		col.shape = seg
		await ToolUtil.tool_add_child(bod, col)

func _enter_tree() -> void:
	line = get_parent()

func _notification(what: int) -> void: ToolUtil.on_pre_save(what, on_pre_save)
