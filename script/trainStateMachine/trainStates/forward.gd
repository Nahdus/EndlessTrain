extends State

var coaches
var couch_idx = 0
var leading_couch_position

var game_start_flag= true

func _init():
	state_name = "forward"

func enter():
	coaches = _target.get_children()
	if game_start_flag:
		game_start_flag = false
		return 
	
#	coaches[0].position.y-=32

func step(delta):
	leading_couch_position=coaches[couch_idx].position
	coaches[couch_idx].position.y-=32
	for idx in range(1,len(coaches)):
		var prev_pos = coaches[idx].position
		coaches[idx].set_position(leading_couch_position)
		leading_couch_position = prev_pos
	_target.position.y+=32
	couch_idx = 0
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_left"):
		_stateMachine.transistion_to_state('left')
	if event.is_action_pressed("ui_right"):
		_stateMachine.transistion_to_state('right')
