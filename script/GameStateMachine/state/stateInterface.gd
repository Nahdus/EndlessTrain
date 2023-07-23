class_name State
extends Resource

var _target
var _stateMachine
var state_name

signal state_change 

func _ready():
	pass

func set_staeMachine(machine):
	_stateMachine = machine

func set_target(target):
	_target = target

func enter():
	pass

func exit():
	pass

func step(delta):
	pass
	
func subscribe_to_state_change(target,method):
	connect("state_change",target,method)
