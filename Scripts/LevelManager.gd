extends Node2D

class_name LevelManager

"""
ovveriding the return name of the base class
use only when wanting to get the class_name
"""
func get_class(): return 'Interactable'

export var click_events_dict = {
	'Chore': 0,
	'Child': 0,
	'Mental': 0,
	'Work': 0
}
export var running_tasks = []
var number_of_allowed_tasks = 2
