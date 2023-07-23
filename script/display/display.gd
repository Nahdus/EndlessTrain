extends Resource

var _target:TileMap
var _tile_index:int
var _margin:Vector2 = Vector2(0,0)

func set_target(target:TileMap):
	_target = target
	
func set_tile(tile_index):
	_tile_index = tile_index

func set_margin_xy(margin:Vector2):
	_margin = margin
	

func _ready():
	_target.clear()
	pass # Replace with function body.
	
func display_3cross5(display_array):
	_target.clear()
	for idx_y in range(len(display_array)):
		for idx_x in range(len(display_array[0])):
			if display_array[idx_y][idx_x][0]==1:
				_target.set_cell(_margin.x+idx_x ,_margin.y+idx_y,_tile_index)

