extends Node2D

onready var gameNode = get_tree().get_root().get_node('game')
onready var train = $train
onready var train_scene = load("res://scene/train.tscn")
onready var obstacles = $obstacles
onready var scoreTracker = gameNode.get_node("scoreTracker")



#music
onready var track_beat = $tick
var music_beat = 3;
var music_time = 0



var beat = 0.2
var _time = 0

var difficulty_beat = 100
var _difficulty_time = 0

var pause = true
signal beat_change
signal pause_unpause

func reset_beats():
	beat = 0.2
	_time = 0
	difficulty_beat = 100
	_difficulty_time = 0


func add_score():
	scoreTracker.add_score(5+randi()%5)


func game_state_change(state):
	if state=="game running":
		randomize()
		reset_beats()
		scoreTracker.reset_score()
		un_pause()
		emit_signal("beat_change",beat)
		obstacles.start_scroll()
		obstacles.reload_track()
	if state =="game Over":
		$restart_timer.start()
	if state == "game off":
		reset_train()
		pause()
		
		
		
func change_beat(in_beat):
	beat=in_beat
	emit_signal("beat_change",beat)

func subscribe_to_beat_change(target,method):
	connect("beat_change",target,method)

func subscribe_to_pause_unpause(target,method):
	connect("pause_unpause",target,method)

	
func _ready():
	$obstacles.subscribe_to_obstacle_pass(self,"add_score")
	gameNode.subscribe_to_state_change(self,'game_state_change')
	subscribe_to_beat_change(obstacles,'set_beat')
	subscribe_to_pause_unpause(obstacles,'scroll_stopstart')
	
func un_pause():
	pause = false
	emit_signal("pause_unpause",!pause)
func pause():
	pause = true
	emit_signal("pause_unpause",!pause)
	
func tick(delta):
	train.tick(delta)
	music_time+=1
	if music_time>music_beat:
		track_beat.play()
		music_time=0
	_difficulty_time+=1
	if _difficulty_time>difficulty_beat:
		var temp_beat=beat*0.80
		_difficulty_time=0
		difficulty_beat = difficulty_beat*3
		change_beat(temp_beat)
		
	


func _process(delta):
	
	if !pause:
		_time+=delta
		if _time>beat:
			tick(delta)
			_time=0
	
			
func _unhandled_input(event):
	if !pause:
		train.handled_input(event)


func reset_train():
	obstacles.clear()
	train.queue_free()
	train=train_scene.instance()
	add_child(train)

func _on_restart_timer_timeout():
	reset_train()
	
