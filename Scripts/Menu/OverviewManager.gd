extends Button

class_name OverviewManager

"""
ovveriding the return name of the base class
use only when wanting to get the class_name
"""
func get_class(): return 'Interactable'

var overview_active = false


func _on_Button_pressed():
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
		for i in get_children():
			i.hide()
