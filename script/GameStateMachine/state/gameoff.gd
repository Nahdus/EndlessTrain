extends State
var Character
var character


func _init():
	state_name = "game off"

func _ready():
	pass # Replace with function body.

func enter():
	Character = load('res://script/characters.gd')
	character = Character.new()
	character.set_target(_target)
	character.clear()
	_target.visible = false
	_target.get_node("countDown").stop()
	_target.get_node("wipe").stop()
	emit_signal("state_change",state_name)
	pass
	
func exit():
	pass
	
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_stateMachine.transistion_to_state("game start")
