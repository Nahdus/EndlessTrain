extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var leftPressFlag = false

var rightPressFlag = false

var button = InputEventAction.new()

var mute_falg = false
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_mute(0,mute_falg)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_buttonLeft_button_down():
	leftPressFlag=true
	button.action = "ui_left"
	button.pressed = true
	Input.parse_input_event(button)
	


func _on_buttonRight_button_down():
	rightPressFlag=true
	button.action = "ui_right"
	button.pressed = true
	Input.parse_input_event(button)
	

func _on_buttonLeft_button_up():
	button.pressed = false
	Input.parse_input_event(button)
	
	


func _on_buttonRight_button_up():
	button.pressed = false
	Input.parse_input_event(button)
	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		button.action = "ui_cancel"
		button.pressed = true
		Input.parse_input_event(button)
#		button.pressed = false
#		Input.parse_input_event(button)
	if event.is_action_pressed("mute"):
		mute_falg=!mute_falg
		get_parent().ui_mute_indicate(mute_falg)
		AudioServer.set_bus_mute(0,mute_falg)


			\
		


func _on_onoff_button_down():
	button.action = "ui_cancel"
	button.pressed = true
	Input.parse_input_event(button)
	


func _on_onoff_button_up():
	button.pressed = false
	Input.parse_input_event(button)
	pass
	


func _on_mute_button_down():
	mute_falg=!mute_falg
	get_parent().ui_mute_indicate(mute_falg)
	AudioServer.set_bus_mute(0,mute_falg)
	pass # Replace with function body.


func _on_mute_button_up():
	pass # Replace with function body.
