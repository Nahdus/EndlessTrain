extends TileMap

var _time = 0
var x_buffer=11
var y_buffer=1
onready var Display = load("res://script/display/display.gd")
var _display
var zero_bin=[[[1],[1],[1]],
			  [[1],[0],[1]],
			  [[1],[0],[1]],
			  [[1],[0],[1]],
			  [[1],[1],[1]]]
			
var one_bin=[ [[0],[1],[0]],
			  [[1],[1],[0]],
			  [[0],[1],[0]],
			  [[0],[1],[0]],
			  [[1],[1],[1]]]

var two_bin=[ [[1],[1],[1]],
			  [[0],[0],[1]],
			  [[1],[1],[1]],
			  [[1],[0],[0]],
			  [[1],[1],[1]]]

var three_bin=[[[1],[1],[1]],
			   [[0],[0],[1]],
			   [[1],[1],[1]],
			   [[0],[0],[1]],
			   [[1],[1],[1]]]
			
var four_bin=[[[1],[0],[1]],
			  [[1],[0],[1]],
			  [[1],[1],[1]],
			  [[0],[0],[1]],
			  [[0],[0],[1]]]

var five_bin=[[[1],[1],[1]],
			  [[1],[0],[0]],
			  [[1],[1],[1]],
			  [[0],[0],[1]],
			  [[1],[1],[1]]]

var six_bin=[[[1],[1],[1]],
			  [[1],[0],[0]],
			  [[1],[1],[1]],
			  [[1],[0],[1]],
			  [[1],[1],[1]]]

var seven_bin=[[[1],[1],[1]],
			   [[0],[0],[1]],
			   [[0],[0],[1]],
			   [[0],[0],[1]],
			   [[0],[0],[1]]]

var eight_bin=[[[1],[1],[1]],
			   [[1],[0],[1]],
			   [[1],[1],[1]],
			   [[1],[0],[1]],
			   [[1],[1],[1]]]

var nine_bin=[[[1],[1],[1]],
			  [[1],[0],[1]],
			  [[1],[1],[1]],
			  [[0],[0],[1]],
			  [[1],[1],[1]]]

var numbers = [zero_bin,one_bin,two_bin,three_bin,four_bin,five_bin,six_bin,seven_bin,eight_bin,nine_bin]
# Called when the node enters the scene tree for the first time.
func _ready():
	clear()
	_display=Display.new()
	_display.set_target(self)
	_display.set_margin_xy(Vector2(11,1))
	
	

var idx = 0

func _process(delta):
	pass
#	_time+=delta
#	if _time>1:
#		_display.display_3cross5(numbers[idx])
#		_time=0
#		idx+=1
#		if idx>len(numbers)-1:
#			idx = 0
		
	
func print_3cross5(number_pixel):
	for idx_y in range(len(number_pixel)):
		for idx_x in range(len(number_pixel[0])):
			if number_pixel[idx_y][idx_x][0]==1:
				set_cell(x_buffer+idx_x ,y_buffer+idx_y,0)
