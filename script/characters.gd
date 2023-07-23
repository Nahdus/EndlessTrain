extends Resource

var _time = 0
var _margin:Vector2=Vector2(11,0)
var y_buffer=1

var _target
var _tile_index =0

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


var letter_S = [[[1],[1],[1]],
				[[1],[0],[0]],
				[[1],[1],[1]],
				[[0],[0],[1]],
				[[1],[1],[1]]]

var letter_T = [[[1],[1],[1]],
				[[0],[1],[0]],
				[[0],[1],[0]],
				[[0],[1],[0]],
				[[0],[1],[0]]]

var letter_A = [[[1],[1],[1]],
				[[1],[0],[1]],
				[[1],[1],[1]],
				[[1],[0],[1]],
				[[1],[0],[1]]]
				
var letter_R = [[[1],[1],[1]],
				[[1],[0],[1]],
				[[1],[1],[0]],
				[[1],[0],[1]],
				[[1],[0],[1]]]

var numbers = [zero_bin,one_bin,two_bin,three_bin,four_bin,five_bin,six_bin,seven_bin,eight_bin,nine_bin]
var letters_START = [letter_S,letter_T,letter_A,letter_R,letter_T]
func set_target(target):
	_target = target

func print_3cross5(number_pixel):
	for idx_y in range(len(number_pixel)):
		for idx_x in range(len(number_pixel[0])):
			if number_pixel[idx_y][idx_x][0]==1:
				_target.set_cell(_margin.x+idx_x ,_margin.y+idx_y,_tile_index)
				
func fill_pixel(pixel_coord):
	_target.set_cell(pixel_coord.x,pixel_coord.y,_tile_index)
	
func erase_pixel(pixel_coord):
	_target.set_cell(pixel_coord.x,pixel_coord.y,-1)
	
func clear():
	_target.clear()



	
func set_tile(tile_index):
	_tile_index = tile_index

func set_margin_xy(margin:Vector2):
	_margin = margin
	
