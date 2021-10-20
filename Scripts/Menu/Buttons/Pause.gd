extends Sprite

func _ready():
	pause_active()

# Declare member variables here. Examples:
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if get_tree().paused == false:
				pause_inactive()
			else:
				pause_active()

func pause_inactive():
	get_tree().paused = true
	for i in get_children():
		i.visible = true
		i.set_process(true)
		i.set_process_input(true)

func pause_active():
	get_tree().paused = false
	for i in get_children():
		i.visible = false
		i.set_process(false)
		i.set_process_input(false)
