extends State

var Characters
var characters

var _time = 0
var beat = 1.0
var countDownChar

var count_idx = 0

var internalState = ["countDown","flashStart","runGame"]
var internalStateIndex=0

var flash_start_countdown = 3
var flash_state = ["display","clear","display","clear"]

var TrackScene = load("res://scene/track.tscn")


func _init():
	state_name = "game start"

func set_target(target):
	_target = target

func enter():
	_target.get_node("countDown").play()
	count_idx = 0
	internalStateIndex = 0
	flash_start_countdown = 3
	Characters = load('res://script/characters.gd')
	characters = Characters.new()
	characters.set_target(_target)
	characters.set_margin_xy(Vector2(11,2))
	countDownChar = [characters.numbers[3],characters.numbers[2],characters.numbers[1]]
	characters.print_3cross5(countDownChar[count_idx])
	emit_signal("state_change",state_name)
	

func exit():
	pass


func flash_start():
	characters.clear()
	for i in range(len(characters.letters_START)):
		characters.set_margin_xy(Vector2(1+5*i,2))
		characters.print_3cross5(characters.letters_START[i])

func tick():
	count_idx+=1
	if internalState[internalStateIndex] == "countDown":
		if count_idx>len(countDownChar)-1:
			count_idx=0
			internalStateIndex+=1
		characters.clear()
		
		characters.print_3cross5(countDownChar[count_idx])
	if internalState[internalStateIndex] == "flashStart":
		beat=0.2
		if flash_start_countdown<0:
			internalStateIndex+=1
		if flash_state[flash_start_countdown] == "display":
			flash_start()
		if flash_state[flash_start_countdown] == "clear":
			characters.clear()
		flash_start_countdown-=1
	if internalState[internalStateIndex] == "runGame":
		_stateMachine.transistion_to_state("game running")
		beat=1.0
		

func step(delta):
	_time+=delta
	if _time>beat:
		tick()
		_time=0
	


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_stateMachine.transistion_to_state("game off")
