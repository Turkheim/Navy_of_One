extends Node3D
var trigger_preasure = 0.0
var grip_preasure = 0.0
var trigger = false
var grip = false
#@onready var xr_controller = $".."



@onready var animation_player = $Hand_Nails_low_R/AnimationPlayer

#func _process(delta):
	
	#trigger_preasure = xr_controller.get_float("trigger") 
	#print(trigger_preasure)
	#grip_preasure = xr_controller.get_float("grip") 
	#print(grip_preasure)
	#
	#trigger = xr_controller.is_button_pressed("trigger_click")
	#grip = xr_controller.is_button_pressed("grip_click")
	#
	
	
func _on_xr_controller_right_button_pressed(name):
	
	if name == "trigger_click" :
		trigger = true

	elif name == "grip_click":
		grip = true

	update_pose()

func _on_xr_controller_right_button_released(name):
	
	if name == "trigger_click" :
		trigger = false

	elif name == "grip_click":
		grip = false
		
	update_pose()
	



func update_pose():
	if trigger == true and grip==true:
		print('fist')
		animation_player.play("Grip")
	elif trigger == false and grip==true:
		print("point")
		animation_player.play("Sign_Point")
		
	elif trigger == true and grip==false:
		print("pipiqq")
		animation_player.play("OK")
	else:
		print('palm')
		animation_player.play("Default pose")
