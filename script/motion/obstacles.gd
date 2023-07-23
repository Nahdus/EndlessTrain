extends TileMap

onready var Character = load("res://script/characters.gd")
var character

var brick = [[[1],[1]],
			 [[1],[1]]]




var obstaches=[
	[[[1],[1],[1],[1],[1]],
	 [[1],[1],[1],[1],[1]]],
	
	[[[1],[1]],
	 [[1],[1]],
	 [[1],[1]],
	 [[1],[1]],
	 [[1],[1]],
	 [[1],[1]]],
	
	[[[1],[1]],
	 [[1],[1]]]
]




var _time = 0
var beat = 0.5

var _internal_state = ["state1","state2"]
var _internal_stateIndex = 0

var shift=0

var number_of_bricks=13

var scroll = false

var obstacleTick=0
var current_obstacle
var current_obstacle_x_pos

signal obstacle_passed

func _ready():
	character=Character.new()
	character.set_target(self)
	current_obstacle = generate_obstacles()

func subscribe_to_obstacle_pass(target,method):
	connect("obstacle_passed",target,method)


func display_bricks(y_margin):
	for i in range(number_of_bricks):
		character.set_margin_xy(Vector2(0,y_margin+i*4))
		character.print_3cross5(brick)
		character.set_margin_xy(Vector2(22,y_margin+i*4))
		character.print_3cross5(brick)

func move_obstacle(obstick):
	character.set_margin_xy(Vector2(current_obstacle_x_pos,obstick))
	character.print_3cross5(current_obstacle)
	
func generate_obstacles():
	var leftright=randf()
	var rand_idx = floor(rand_range(0,len(obstaches)-1))
	var obs = obstaches[rand_idx]
	if leftright>0.5:
		current_obstacle_x_pos = floor(rand_range(2,10))
	if leftright<0.5:
		current_obstacle_x_pos = 22-len(obs[0])-floor(rand_range(2,10))
	
	return obs
	
func tick():
	character.clear()
	display_bricks(shift)
	move_obstacle(obstacleTick)
	shift+=1
	shift=shift%4
	obstacleTick+=1
	if obstacleTick>50:
		current_obstacle=generate_obstacles()
		obstacleTick=0
		emit_signal("obstacle_passed")
func start_scroll():
	scroll = true

func stop_scroll():
	scroll = false
	
func set_beat(sec):
	beat = sec
	
func get_beat():
	return beat


func reload_track():
	obstacleTick=0
	shift=0
	current_obstacle=generate_obstacles()
	

func scroll_stopstart(trueFalse):
	if trueFalse:
		start_scroll()
	else:
		stop_scroll()

func _process(delta):
	if scroll == true:
		_time+=delta
		if _time>beat:
			tick()
			_time=0
			

