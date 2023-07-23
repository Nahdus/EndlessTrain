extends GameMachine


func add_state_to_table(state_obj,transistion_array):
	var map = []
	_states[state_obj.state_name]=state_obj
	for each in transistion_array:
		map.append(each.state_name)
	_tansistion_table[state_obj.state_name] = map
	
func set_current_state(state_obj:State):
	_current_state = state_obj
	_current_state.enter()
	
func transistion_to_state(state_name:String):
	if state_name in _tansistion_table[_current_state.state_name]:
		_current_state.exit()
		_current_state=_states[state_name]
		_current_state.enter()

func step(delta):
	_current_state.step(delta)

func handle_input(event):
	_current_state._unhandled_input(event)
	
