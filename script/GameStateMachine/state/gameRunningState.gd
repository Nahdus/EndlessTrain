extends State

var Characters
var characters

var _time = 0
var beat = 2.0


func _init():
	state_name = "game running"

func set_target(target):
	_target = target

func enter():
	Characters = load('res://script/characters.gd')
	characters = Characters.new()
	characters.set_target(_target)
	emit_signal("state_change",state_name)
		

func exit():
	pass


func flash_start():
	characters.clear()
	for i in range(len(characters.letters_START)):
		characters.set_margin_xy(Vector2(1+5*i,1))
		characters.print_3cross5(characters.letters_START[i])



func tick():
	pass
	
		



func step(delta):
	_time+=delta
	if _time>beat:
		tick()
		_time=0
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_stateMachine.transistion_to_state("game off")
	
