extends Node2D

class_name LevelManager

export var click_events_dict = {
	'Chore': 0,
	'Child': 0,
	'Mental': 0,
	'Work': 0
}
export var running_tasks = []
var number_of_allowed_tasks = 2
