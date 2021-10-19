extends Sprite

class_name Interactable

#sprites in use
onready var og_sprite = load("res://Sprites/icon.png")
onready var selected_sprite = load("res://Sprites/icon_green.png")

#homemade timer
export var re_init_timer = 1
var timer

#accessing outside variables selection
export var amount_increment = 1
var selected = false
var incrementing_dict = 0
var num_life = 2
var error_life = 4

#fun shit
var rand_generate = RandomNumberGenerator.new()

"""
ovveriding the return name of the base class
use only when wanting to get the class_name
"""
func get_class(): return 'Interactable'

func _ready():
	timer = re_init_timer
	
	get_child(0).text = get_name()

"""
if we want to increment things with muli selection, 
add the selected nodes to a list on level manager when clicked
check before appending list to see if list is too long 
(symbolizing the number of activities active)
"""

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if not self.selected and get_owner().running_tasks.size() < get_owner().number_of_allowed_tasks:
				selected_init()
			elif get_owner().running_tasks.size() >= get_owner().number_of_allowed_tasks and not self.selected:
				floating_number('Only Two Tasks \n aloud at once! \n Turn one off to \n start another!', error_life, true)
				print('Too many tasks running! Shut one down!')
			elif self.selected:
				deselect_init()


func _process(delta):
	if self.selected:
		timer -= get_process_delta_time()
		if timer <= 0:
			timer = re_init_timer
			incrementing_dict+=amount_increment
			floating_number(str(amount_increment), num_life)
			
	elif not self.selected :
		timer = re_init_timer

func floating_number(message, timer_speed, is_error_message=false):
	var f_label = Label.new()
	var tween_pos = Tween.new()
	var tween_opacity = Tween.new()
	
	rand_generate.randomize()
	var rand_X = rand_generate.randf_range(-50, 50)
	var rand_Y = rand_generate.randf_range(-40, -50)
	
	f_label.set_text(message)
	if is_error_message:
		f_label.set_position(Vector2(30, -50))
	else:
		f_label.set_position(Vector2(rand_X, rand_Y))
	
	tween_pos.interpolate_property(f_label, "rect_position:y", rand_Y, -60, timer_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween_opacity.interpolate_property(f_label, "modulate:a", 1.0, 0, timer_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	add_child(f_label)
	add_child(tween_pos)
	add_child(tween_opacity)

	tween_pos.start()
	tween_opacity.start()
	
	yield(get_tree().create_timer(timer_speed), "timeout")
	
	f_label.queue_free()
	tween_pos.queue_free()
	tween_opacity.queue_free()
	
	

func selected_init():
	self.selected = true
	texture = selected_sprite
	incrementing_dict = 0
	get_owner().running_tasks.append(self)
	
func deselect_init():
	print('unselcting')
	texture = og_sprite
	get_owner().running_tasks.erase(self)
	get_owner().click_events_dict[get_name()]+=incrementing_dict
	print(get_owner().click_events_dict)
	self.selected = false

		
