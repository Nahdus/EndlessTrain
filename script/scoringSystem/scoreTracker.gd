extends TileMap

var Character
var character


var score_places=[Vector2(68,9),Vector2(64,9),Vector2(60,9),Vector2(56,9),Vector2(52,9)]
var high_score_places=[Vector2(68,23),Vector2(64,23),Vector2(60,23),Vector2(56,23),Vector2(52,23)]

var _time = 0
var beat=0.1

var score_val=0

var new_score=0

var high_score_val = 0

var clear_area
var high_score_chime_flag = true

func create_area_earser():
	var rows = []
	var columns = []
	rows.resize(5)
	columns.resize(19)
	columns.fill([1])
	rows.fill(columns)
	clear_area = rows

func score(number,place):
	character.set_tile(0)
	character.set_margin_xy(place)
	character.print_3cross5(character.numbers[number])

func clear_score():
	character.set_tile(-1)
	character.set_margin_xy(score_places[4])
	character.print_3cross5(clear_area)
	
func clear_high_score():
	character.set_tile(-1)
	character.set_margin_xy(high_score_places[4])
	character.print_3cross5(clear_area)
	
func high_score(number,place):
	character.set_margin_xy(place)
	character.print_3cross5(character.numbers[number])


func _ready():
	create_area_earser()
	Character = load("res://script/characters.gd")
	character = Character.new()
	character.set_target(self)
	for each in score_places:
		score(0,each)
		
	for each in high_score_places:
		score(0,each)


func update_score(score_val):
	
	if score_val<100000:
		clear_score()
		for idx in range(len(score_places)):
			var number = floor(((score_val%int(pow(10,(1+idx))))/pow(10,idx)))
			score(number,score_places[idx])
	if score_val-high_score_val>9:
		high_score_val=score_val
		update_high_score(high_score_val)

func update_high_score(score_val):
	if score_val<100000:
		clear_high_score()
		for idx in range(len(score_places)):
			var number = floor(((score_val%int(pow(10,(1+idx))))/pow(10,idx)))
			score(number,high_score_places[idx])
	
		
	
func tick():
	if new_score>score_val:
		score_val+=1
		update_score(score_val)
	if new_score<score_val:
		score_val-=1
		update_score(score_val)
	if new_score>high_score_val:
		high_score_val+=1
		update_high_score(high_score_val)
	
func add_score(s):
	$score.play()
	new_score+=s
	if new_score>high_score_val and new_score>99 and high_score_chime_flag:
		$highScore.play()
		high_score_chime_flag=false
			

func reset_score():	
	new_score=0
	high_score_chime_flag=true



func _process(delta):
	_time+=delta
	if _time>beat:
		tick()
		_time = 0

	
	
	
	


