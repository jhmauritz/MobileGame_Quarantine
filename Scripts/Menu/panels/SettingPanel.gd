extends OverviewManager

func _process(delta):
	if not is_visible_in_tree():
		pressed = false
		get_children()[0].hide()


func _on_Settings_pressed():
	if pressed:
		for i in get_tree().get_current_scene().get_children():
			if i.get_name() == 'PauseButton':
				pass
			else:
				i.set_process_input(false)
		get_children()[0].show()
	else:
		for i in get_tree().get_current_scene().get_children():
			print(i.get_name())
			i.set_process_input(true)
		get_children()[0].hide()
