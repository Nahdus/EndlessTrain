extends Node2D

#onready var gameNode = get_tree().get_root().get_node('game')



onready var TrainMachine = load("res://script/trainStateMachine/trainStateMachine.gd")
onready var ForwardState = load("res://script/trainStateMachine/trainStates/forward.gd")
onready var LeftState = load("res://script/trainStateMachine/trainStates/left.gd")
onready var RightState = load("res://script/trainStateMachine/trainStates/right.gd")
onready var Track = get_parent()


var trainMachine
var forwardState
var leftState
var rightState
#
#var beat = 1.0
#var _time = 0

func _ready():
	
	trainMachine = TrainMachine.new()
	
	forwardState = ForwardState.new()
	leftState = LeftState.new()
	rightState = RightState.new()
	
	
	forwardState.set_target(self)
	forwardState.set_staeMachine(trainMachine)
	trainMachine.add_state_to_table(forwardState,[leftState,rightState])
	
	leftState.set_target(self)
	leftState.set_staeMachine(trainMachine)
	trainMachine.add_state_to_table(leftState,[forwardState])

	rightState.set_target(self)
	rightState.set_staeMachine(trainMachine)
	trainMachine.add_state_to_table(rightState,[forwardState])
	
	
	trainMachine.set_current_state(forwardState)

func tick(delta):
	trainMachine.step(delta)
	
#func _process(delta):
#	if !pause:
#		_time+=delta
#		if _time>beat:
#			tick(delta)
#			_time = 0
		
func handled_input(event):
	trainMachine._unhandled_input(event)


func _on_Area2D_body_entered(body):
	
	Track.pause()
	Track.gameNode.game_over()
	pass # Replace with function body.
