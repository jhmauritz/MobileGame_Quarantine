extends Sprite


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			get_tree().change_scene("res://Levels/HomeScreen.tscn")
