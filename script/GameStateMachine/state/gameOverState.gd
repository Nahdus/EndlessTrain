extends State

var Characters
var characters


var beat = 1.0
var _time = 0

var counter = 0

var internal_state = ["wait","animate","erase"]
var internal_state_index = 0
func _init():
	state_name = "game Over"

func set_target(target):
	_target = target

func enter():
	beat = 1.0
	Characters = load('res://script/characters.gd')
	characters = Characters.new()
	characters.set_target(_target)
	internal_state_index=0
	counter=0
	emit_signal("state_change",state_name)
	pass

func exit():
	pass

func clean(count):
	characters.fill_pixel(Vector2(count%24,floor(count/24)))
	pass

func wipe(count):	
	characters.erase_pixel(Vector2(count%24,floor(count/24)))

func step(delta):
	_time+=delta
	if internal_state[internal_state_index]=="wait":
		if _time > beat:
			internal_state_index+=1
			_target.get_node('wipe').play()
			beat=0.0001
			_time = 0
	if internal_state[internal_state_index]=="animate":
		if _time > beat:
			clean(counter)
			counter+=1
			_time = 0
			if counter>1249:
				internal_state_index+=1
				_target.get_node('wipe').play()
				
	if internal_state[internal_state_index]=="erase":
		wipe(counter)
		counter-=1
		if counter<0:
			_stateMachine.transistion_to_state("game start")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_stateMachine.transistion_to_state("game off")
