extends State

var coaches
var couch_idx = 0
var leading_couch_position

func _init():
	state_name = "right"

func enter():
	coaches = _target.get_children()
	

func step(delta):
	leading_couch_position=coaches[couch_idx].position
	coaches[couch_idx].position.x+=32
	for idx in range(1,len(coaches)):
		var prev_pos = coaches[idx].position
		coaches[idx].set_position(leading_couch_position)
		leading_couch_position = prev_pos
	couch_idx = 0

func _unhandled_input(event):
	if event.is_action_released("ui_right"):
		_stateMachine.transistion_to_state('forward')
	
