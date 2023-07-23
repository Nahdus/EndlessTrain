extends Node2D

#load files
onready var StateMachine = load("res://script/GameStateMachine/gameStateMachine.gd")
onready var GameOverState = load("res://script/GameStateMachine/state/gameOverState.gd")
onready var GameStartState = load("res://script/GameStateMachine/state/gameStartState.gd")
onready var GameRunningState = load("res://script/GameStateMachine/state/gameRunningState.gd")
onready var GameOffState = load("res://script/GameStateMachine/state/gameoff.gd")
onready var ui = $ui



#instanciate variables

var stateMachine:GameMachine
var gameOverState:State
var gameStartState:State
var gameRunningState:State
var gameOffState:State

onready var trainNode = $train

#game_states = ["game start","game running","game Over"]
signal game_state


func hideShowgame(tf):
	ui.visible=tf
	$scoreTracker.visible = tf
	$track.visible = tf


func state_changed(state):
	emit_signal("game_state",state)
	if state=="game start":
		hideShowgame(true)
	if state=="game off":
		hideShowgame(false)
	else:
		ui.visible=true
		


func subscribe_to_state_change(target,method):
	connect("game_state",target,method)


func connect_state(state):
	state.set_target(ui)
	state.set_staeMachine(stateMachine)
	state.subscribe_to_state_change(self,'state_changed')


func _ready():
	#the machine
	stateMachine = StateMachine.new()
	
	#the states
	gameOverState = GameOverState.new()
	connect_state(gameOverState)
	
	gameStartState = GameStartState.new()
	connect_state(gameStartState)

	gameRunningState = GameRunningState.new()
	connect_state(gameRunningState)
	
	gameOffState = GameOffState.new()
	connect_state(gameOffState)

	stateMachine.add_state_to_table(gameStartState,[gameRunningState,gameOverState,gameOffState])
	stateMachine.add_state_to_table(gameOverState,[gameStartState,gameOffState])
	stateMachine.add_state_to_table(gameRunningState,[gameOverState,gameOffState])
	stateMachine.add_state_to_table(gameOffState,[gameStartState])
	stateMachine.set_current_state(gameOffState)
	
func game_over():
	$collision.play()
	stateMachine.transistion_to_state("game Over")
	
	
func _process(delta):
	stateMachine.step(delta)
	
	
func _unhandled_input(event):
	stateMachine.handle_input(event)

func ui_mute_indicate(TorF):
	if TorF:
		$ui/muteUnute.play("mute")
	else:
		$ui/muteUnute.play("unmute")



